//
//  AppsViewModel.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import Foundation


enum AppsViewModelState {
    case idle
    case loading(Bool)
    case success
    case failure(NetworkError)
}

final class AppsViewModel {
    typealias OnChange = (AppsViewModelState) -> Void

    var onChange: OnChange?
    
    var model: [AppGroup] = []
    var socialApps: [SocialApp] = []
    
    init() {
        emit(state: .idle)
    }
    
    func emit(state: AppsViewModelState) {
        self.onChange?(state)
    }
    
    func fetchGroups() {
        
        emit(state: .loading(true))
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
            
        NetworkManager.shared.fetchSocialApps { [weak self] result in
            dispatchGroup.leave()
            self?.emit(state: .loading(false))
            
            switch result {
            case .failure(let error):
                self?.emit(state: .failure(error))
            case .success(let response):
                self?.socialApps = response
            }
        }
        
        dispatchGroup.enter()
            
        NetworkManager.shared.fetchAppGroup(with: .tr) { [weak self] result in
            dispatchGroup.leave()
            self?.emit(state: .loading(false))
            
            switch result {
            case .failure(let error):
                self?.emit(state: .failure(error))
            case .success(let response):
                self?.model.append(response)
            }
        }
        
        dispatchGroup.enter()
        
        NetworkManager.shared.fetchAppGroup(with: .us) { [weak self] result in
            dispatchGroup.leave()
            self?.emit(state: .loading(false))
            
            switch result {
            case .failure(let error):
                self?.emit(state: .failure(error))
            case .success(let response):
                self?.model.append(response)
            }
        }
        
        dispatchGroup.enter()
        
        NetworkManager.shared.fetchAppGroup(with: .en) { [weak self] result in
            dispatchGroup.leave()
            self?.emit(state: .loading(false))
            
            switch result {
            case .failure(let error):
                self?.emit(state: .failure(error))
            case .success(let response):
                self?.model.append(response)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("completed your dispatch group task")
            self.emit(state: .success)
        }
    }
}
