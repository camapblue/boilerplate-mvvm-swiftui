//
//  LoadListViewModel.swift
//  boilerplate-mvvm-swiftui
//
//  Created by @camapblue on 1/23/22.
//

import Foundation
import Combine

class LoadListViewModel<Item: Equatable> : ObservableObject {
    private let loadListUseCase: LoadListUseCase<Item>
    private var bag = Set<AnyCancellable>()
    
    private var params: [String: Any]?
    
    var isFirstLaunch: Bool = false
    @Published var isLoading: Bool = false
    @Published var isFinished: Bool = false
    @Published var items: [Item] = [Item]()
    
    private let runLoadListSubject = PassthroughSubject<[String: Any]?, Never>()
    
    init(loadListUseCase: LoadListUseCase<Item>, params: [String: Any]? = nil) {
        self.loadListUseCase = loadListUseCase
        self.params = params
        
        runLoadListSubject
            .flatMap({ [unowned self] (paratemers) -> Future<[Item], Error> in
                self.isLoading = true
                
                return try! self.loadListUseCase.loadItems(params: paratemers)
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    print("Error now")
                }
            }, receiveValue: { [weak self] items in
                guard let self = self else { return }
                
                let uniquedItems = items.removingDuplicates()
                if uniquedItems.isEmpty {
                    self.isFinished = true
                }
                self.items = self.items + uniquedItems
                
                self.isLoading = false
            })
            .store(in: &bag)
    }
    
    func start() {
        isFirstLaunch = true
        var params = self.params ?? [String: Any]()
        params["index"] = 0
        
        runLoadListSubject.send(params)
    }
    
    func loadNext() {
        
    }
    
    func refresh() {
        
    }
    
    func reload() {
        
    }
}
