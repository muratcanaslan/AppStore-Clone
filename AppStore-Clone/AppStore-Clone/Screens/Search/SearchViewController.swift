//
//  SearchViewController.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 3.02.2023.
//

import UIKit

final class SearchViewController: UICollectionViewController {
    
    let viewModel = SearchViewModel()
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Search"
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCollectionCell.self, forCellWithReuseIdentifier: SearchResultCollectionCell.reuseIdentifier)
        
        setupViewModel()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewModel() {
        viewModel.onChange = viewObserver
        viewModel.fetchSearchResults()
    }
    
    private func viewObserver(state: SearchViewModelState) {
        switch state {
        case .idle:
            break
        case .loading(let isLoading):
            break
        case .success:
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .failure(let error):
            break
        }
    }
}

//MARK: - Collection View Data Source
extension SearchViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionCell.reuseIdentifier, for: indexPath) as? SearchResultCollectionCell else { return .init() }
        cell.configure(with: viewModel.getResultItem(at: indexPath.item))
        return cell
    }
}

//MARK: - Collection View Delegate Flow Layout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 360)
    }
}
