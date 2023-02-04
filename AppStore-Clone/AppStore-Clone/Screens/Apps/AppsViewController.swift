//
//  AppsViewController.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 3.02.2023.
//

import UIKit

final class AppsViewController: BaseCollectionViewController {
    
    private let viewModel = AppsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Apps"
        
        view.backgroundColor = .white
        
        collectionView.register(
            AppGroupCollectionCell.self,
            forCellWithReuseIdentifier: AppGroupCollectionCell.reuseIdentifier
        )
        
        collectionView.register(
            AppsHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: AppsHeaderCollectionReusableView.reuseIdentiifer
        )
        
        setupViewModel()

        viewModel.fetchGroups()
    }
    
    private func setupViewModel() {
        viewModel.onChange = viewObserver
    }
    
    private func viewObserver(state: AppsViewModelState) {
        switch state {
        case .idle:
            break
        case .loading(let isLoading):
            isLoading ? startLoading() : stopLoading()
        case .success:
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .failure(let error):
            break
        }
    }
}

//MARK: - Collection View DataSource & Delegate
extension AppsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppGroupCollectionCell.reuseIdentifier, for: indexPath) as? AppGroupCollectionCell else { return .init() }
        cell.configure(with: viewModel.model[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppsHeaderCollectionReusableView.reuseIdentiifer, for: indexPath) as? AppsHeaderCollectionReusableView else { return .init() }
        header.configure(with: viewModel.socialApps)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
}

//MARK: - Collection View
extension AppsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
