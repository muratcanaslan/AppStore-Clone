//
//  SearchViewController.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 3.02.2023.
//

import UIKit

final class SearchViewController: UICollectionViewController {
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.title = "Search"
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCollectionCell.self, forCellWithReuseIdentifier: SearchResultCollectionCell.reuseIdentifier)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Collection View Data Source
extension SearchViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionCell.reuseIdentifier, for: indexPath)
        return cell
    }
}

//MARK: - Collection View Delegate Flow Layout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 250)
    }
}
