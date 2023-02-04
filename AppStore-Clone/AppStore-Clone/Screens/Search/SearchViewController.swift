//
//  SearchViewController.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 3.02.2023.
//

import UIKit

final class SearchViewController: UICollectionViewController {
    
    private let viewModel = SearchViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    private var timer = Timer()
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Search"
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCollectionCell.self, forCellWithReuseIdentifier: SearchResultCollectionCell.reuseIdentifier)
        
        setupViewModel()
        setupSearchBar()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func setupViewModel() {
        viewModel.onChange = viewObserver
        viewModel.keyword = ""
    }
    
    private func viewObserver(state: SearchViewModelState) {
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

//MARK: - SearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { _ in
            self.viewModel.keyword = searchText
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.keyword = ""
    }
}
