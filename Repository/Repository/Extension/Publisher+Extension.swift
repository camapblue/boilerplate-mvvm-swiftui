//
//  Publisher+Extension.swift
//  Repository
//
//  Created by @camapblue on 1/8/22.
//

import Combine

extension Publishers {
    struct RetryIf<P: Publisher>: Publisher {
        typealias Output = P.Output
        typealias Failure = P.Failure
        
        let publisher: P
        let times: Int
        let condition: (P.Failure) -> AnyPublisher<Bool, Never>
                
        func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            guard times > 0 else { return publisher.receive(subscriber: subscriber) }
            
            publisher.catch { (error: P.Failure) -> AnyPublisher<Output, Failure> in
                return condition(error)
                    .flatMap { doRetry -> AnyPublisher<Output, Failure> in
                        if doRetry {
                            return RetryIf(publisher: publisher, times: times - 1, condition: condition).eraseToAnyPublisher()
                        } else {
                            return Fail(error: error).eraseToAnyPublisher()
                        }
                    }
                    .eraseToAnyPublisher()
            }.receive(subscriber: subscriber)
        }
    }
}

extension Publisher {
    func retry(times: Int, if condition: @escaping (Failure) -> AnyPublisher<Bool, Never>) -> Publishers.RetryIf<Self> {
        Publishers.RetryIf(publisher: self, times: times, condition: condition)
    }
}
