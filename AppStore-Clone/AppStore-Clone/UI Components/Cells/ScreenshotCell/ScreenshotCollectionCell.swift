//
//  ScreenshotCollectionCell.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 19.02.2023.
//

import UIKit

class ScreenshotCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ScreenshotCollectionCell"
    
    let imageView = UIImageView(cornerRadius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    func configure(with url: URL) {
        imageView.downloadedFrom(url: url)
    }
}
