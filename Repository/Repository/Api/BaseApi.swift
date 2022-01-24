//
//  BaseApi.swift
//  Repository
//
//  Created by @camapblue on 1/8/22.
//

import Combine

typealias JsonResponse = Dictionary<String, Any>

public class BaseApi {
    private let baseUrl: BaseUrl
    private let urlSession: URLSession
    private let retryTimes: Int
    
    public init(_ baseUrl: BaseUrl, urlSession: URLSession = URLSession.shared, retryTimes: Int = 3) {
        self.baseUrl = baseUrl
        self.urlSession = urlSession
        self.retryTimes = retryTimes
    }
    
    func refreshToken() -> AnyPublisher<String, Never> {
        return Future { promise in
            promise(.success("new_token"))
        }
        .eraseToAnyPublisher()
    }
    
    func get(path: Endpoints) -> AnyPublisher<JsonResponse, Error> {
        let url = baseUrl.getUrl(of: path)
        
        return Deferred  {
            Future { [weak self] promise in
                guard let self = self else {
                    promise(.success(JsonResponse()))
                    return
                }
                    let task = self.urlSession
                    .dataTask(with: url) { data, response, error in
                        if error == nil {
                            if let httpResponse = response as? HTTPURLResponse {
                                if httpResponse.statusCode == 200 {
                                    if let json = try! JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any] {
                                        promise(.success(json))
                                        return
                                    }
                                } else if httpResponse.statusCode == 401 {
                                    promise(.failure(UnauthorizedError.tokenExpired))
                                    return
                                }
                            }
                            promise(.success(JsonResponse()))
                        } else {
                            promise(.failure(error!))
                        }
                    }
                task.resume()
            }
        }.retry(times: retryTimes, if: { [unowned self] error in
            if error is UnauthorizedError {
                return refreshToken()
                    .map { newToken  in
                        // update new token to Authorization object here
                        
                        return true
                    }
                    .eraseToAnyPublisher()
            }
            return Just(false).eraseToAnyPublisher()
        })
        .eraseToAnyPublisher()
    }
}
