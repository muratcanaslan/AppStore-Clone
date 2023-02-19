//
//  AppDetailViewController.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 18.02.2023.
//

import UIKit

final class AppDetailViewController: BaseCollectionViewController {
    
    let viewModel: AppDetailViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = viewModel.model.name ?? "-"
        view.backgroundColor = .white
        
        collectionView.register(AppDetailInformationCollectionCell.self, forCellWithReuseIdentifier: AppDetailInformationCollectionCell.reuseIdentifier)
        collectionView.register(AppDetailPreviewCollectionCell.self, forCellWithReuseIdentifier: AppDetailPreviewCollectionCell.reuseIdentifier)
        collectionView.register(AppDetailReviewCollectionCell.self, forCellWithReuseIdentifier: AppDetailReviewCollectionCell.reuseIdentifier)
        
        setupViewModel()
        
        viewModel.fetchAppDetail()
    }
    
    init(model: FeedResult) {
        self.viewModel = AppDetailViewModel(model: model)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewModel() {
        viewModel.onChange = viewObserver
    }
    
    private func viewObserver(state: AppDetailModelState) {
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
            print(error.localizedDescription)
        }
    }
}

//MARK: - CollectionView Delegate & DataSource
extension AppDetailViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.cells[indexPath.item] {
        case .information(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailInformationCollectionCell.reuseIdentifier, for: indexPath) as? AppDetailInformationCollectionCell else { return .init() }
            cell.configure(with: model)
            return cell
        case .preview(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailPreviewCollectionCell.reuseIdentifier, for: indexPath) as? AppDetailPreviewCollectionCell else { return .init() }
            cell.configure(with: model)
            return cell
        case .rating(let model):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailReviewCollectionCell.reuseIdentifier, for: indexPath) as? AppDetailReviewCollectionCell else { return .init() }
            cell.configure(with: model)
            return cell
        }
    }
}

//MARK: - CollectionView DelegateFlowLayout
extension AppDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.cells[indexPath.item] {
        case .information(let model):
            let dummyCell = AppDetailInformationCollectionCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.configure(with: model)
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            
            return .init(width: view.frame.width, height: estimatedSize.height)
        case .preview(let model):
            let dummyCell = AppDetailPreviewCollectionCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            dummyCell.configure(with: model)
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
            return .init(width: view.frame.width, height: estimatedSize.height)
        case .rating:
            return .init(width: view.frame.width, height: 280)
        }
    }
}
