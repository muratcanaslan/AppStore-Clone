//
//  AppDetailReviewHorizontalController.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 19.02.2023.
//

import UIKit

class AppDetailReviewHorizontalController: HorizontalSnappingController {
    
    var model: [Entry] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ReviewCollectionCell.self, forCellWithReuseIdentifier: ReviewCollectionCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func configure(with model: [Entry]) {
        self.model = model
    }
}

//MARK: - CollectionView Delegate&Datasource
extension AppDetailReviewHorizontalController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionCell.reuseIdentifier, for: indexPath) as? ReviewCollectionCell else { return .init() }
        cell.configure(with: model[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 20, right: 0)
    }
}

//MARK: - CollectionView DelegateFlowLayout
extension AppDetailReviewHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: 200)
    }
}
