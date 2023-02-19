//
//  AppDetailReviewCollectionCell.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 19.02.2023.
//

import UIKit

final class AppDetailReviewCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AppDetailReviewCollectionCell"
    
    let horizontalController = AppDetailReviewHorizontalController()
    
    let titleLabel = UILabel(font: .systemFont(ofSize: 24, weight: .bold))
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        autoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        titleLabel.text = "Rating & Reviews"
    }
    
    func configure(with model: [Entry]) {
        self.horizontalController.configure(with: model)
    }
    
    private func autoLayout() {
        addSubview(titleLabel)
        addSubview(horizontalController.view)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
}
