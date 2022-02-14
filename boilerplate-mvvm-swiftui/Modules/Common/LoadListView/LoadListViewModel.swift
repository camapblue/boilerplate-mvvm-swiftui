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
    @Published var isRefreshing = false
    @Published var isLoading: Bool = false
    @Published var isFinished: Bool = false
    @Published var items: [Item] = [Item]()
    
    private let runLoadListSubject = PassthroughSubject<[String: Any]?, Never>()
    
    init(loadListUseCase: LoadListUseCase<Item>, params: [String: Any]? = nil) {
        self.loadListUseCase = loadListUseCase
        self.params = params
        
        runLoadListSubject
            .subscribe(on: DispatchQueue.global())
            .flatMap({ [unowned self] (paratemers) -> Future<[Item], Error> in
                self.isLoading = true
                if self.isRefreshing {
                    self.loadListUseCase.forceToRefresh()
                }
                
                return try! self.loadListUseCase.loadItems(params: paratemers)
            })
            .receive(on: DispatchQueue.main)
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
                print("IS refreshing = \(self.isRefreshing)")
                if self.isRefreshing {
                    self.items = uniquedItems
                    self.isRefreshing = false
                } else {
                    self.items = self.items + uniquedItems
                }
                
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
        isRefreshing = true
        var params = self.params ?? [String: Any]()
        params["index"] = 0
        
        runLoadListSubject.send(params)
    }
    
    func reload() {
        
    }
}
