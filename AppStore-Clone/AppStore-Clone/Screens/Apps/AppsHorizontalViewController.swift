//
//  AppsHorizontalViewController.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import UIKit

enum Spacing {
    static let topBottomPadding: CGFloat = 12
    static let minimumLineSpacing: CGFloat = 10
}

final class AppsHorizontalViewController: HorizontalSnappingController {
    
    private var results: [FeedResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppsRowCollectionCell.self,
                                forCellWithReuseIdentifier: AppsRowCollectionCell.reuseIdentifier)
        
        collectionView.contentInset = .init(
            top: 0,
            left: 16,
            bottom: 0,
            right: 16
        )
    }
    
    func configure(with model: [FeedResult]) {
        results = model
    }
}

//MARK: - CollectionView DataSource
extension AppsHorizontalViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsRowCollectionCell.reuseIdentifier, for: indexPath) as? AppsRowCollectionCell else { return .init() }
        cell.configure(with: results[indexPath.row])
        return cell
    }
}

extension AppsHorizontalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - (2 * Spacing.topBottomPadding) - (2 * Spacing.minimumLineSpacing)) / 3
        return .init(width: view.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Spacing.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Spacing.minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: Spacing.topBottomPadding, left: 16, bottom: Spacing.topBottomPadding, right: 0)
    }
}
