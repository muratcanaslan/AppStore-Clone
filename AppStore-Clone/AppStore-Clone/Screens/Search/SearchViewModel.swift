//
//  SearchViewModel.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import Foundation

enum SearchViewModelState {
    case idle
    case loading(Bool)
    case success
    case failure(NetworkError)
}

final class SearchViewModel {
    typealias OnChange = (SearchViewModelState) -> Void

    var onChange: OnChange?
    
    var keyword: String? {
        didSet {
            fetchSearchResults()
        }
    }
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
    
    private func fetchSearchResults() {
        
        if keyword.isNilOrEmpty { removeResults(); return }
        
        emit(state: .loading(true))
        
        NetworkManager.shared.fetchSearchResults(with: keyword ?? "") { [weak self] result in
            
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
    
    private func removeResults() {
        results = []
        self.emit(state: .success)
    }
}

