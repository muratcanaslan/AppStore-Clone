//
//  SearchViewModel.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import Foundation

typealias OnChange = (SearchViewModelState) -> Void

enum SearchViewModelState {
    case idle
    case loading(Bool)
    case success
    case failure(NetworkError)
}

final class SearchViewModel {
    
    var onChange: OnChange?
    
    var results: [SearchResult] = []
    
    init() {
        emit(state: .idle)
    }
    
    var numberOfItems: Int {
        results.count
    }
    
    func getResultItem(at index: Int) -> SearchResult {
        return results[index]
    }
    
    
    
    func emit(state: SearchViewModelState) {
        self.onChange?(state)
    }
    
    func fetchSearchResults() {
        
        emit(state: .loading(true))
        
        NetworkManager.shared.fetchSearchResults { [weak self] result in
            
            self?.emit(state: .loading(false))
            
            switch result {
            case .failure(let error):
                self?.emit(state: .failure(error))
            case .success(let response):
                self?.results = response.results
                
                self?.emit(state: .success)
            }
        }
    }
}
