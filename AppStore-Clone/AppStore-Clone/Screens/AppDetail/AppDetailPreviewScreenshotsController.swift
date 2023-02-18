//
//  AppDetailPreviewScreenshotsController.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 19.02.2023.
//

import UIKit

final class AppDetailPreviewScreenshotsController: HorizontalSnappingController {
    
    var urls: [URL] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ScreenshotCollectionCell.self, forCellWithReuseIdentifier: ScreenshotCollectionCell.reuseIdentifier)
        
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func configure(with urls: [URL]) {
        self.urls = urls
    }
}

//MARK: - CollectionView Delegate&DataSource
extension AppDetailPreviewScreenshotsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCollectionCell.reuseIdentifier, for: indexPath) as? ScreenshotCollectionCell else { return .init() }
        cell.configure(with: urls[indexPath.item])
        return cell
    }
}

//MARK: - CollectionView DelegateFlowLayout
extension AppDetailPreviewScreenshotsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width / 1.2,  height: view.frame.height)
    }
}
