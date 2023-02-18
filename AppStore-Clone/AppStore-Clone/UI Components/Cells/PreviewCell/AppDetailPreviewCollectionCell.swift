//
//  AppDetailPreviewCollectionCell.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 19.02.2023.
//

import UIKit

class AppDetailPreviewCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AppDetailPreviewCollectionCell"
    
    let titleLabel = UILabel(font: .systemFont(ofSize: 24, weight: .bold))
    let horizontalController = AppDetailPreviewScreenshotsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.text = "Preview"
    }
    
    func configure(with urls: [URL]) {
        horizontalController.configure(with: urls)
    }
    
    private func autoLayout() {
        addSubview(titleLabel)
        addSubview(horizontalController.view)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
}
