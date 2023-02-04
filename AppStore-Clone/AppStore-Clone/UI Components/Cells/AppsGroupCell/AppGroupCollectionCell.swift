//
//  AppGroupCollectionCell.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import UIKit

final class AppGroupCollectionCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseIdentifier = "AppGroupCollectionCell"
    
    private let sectionLabel: UILabel = .init(font: .boldSystemFont(ofSize: 30))
    private let horizontalController = AppsHorizontalViewController()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        autoLayoutSectionLabel()
        autoLayoutHorizontalController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: AppGroup) {
        self.sectionLabel.text = model.feed?.title ?? "-"
        horizontalController.configure(with: model.feed?.results ?? [])
    }
    
    //MARK: - UI Helpers
    
    private func autoLayoutSectionLabel() {
        addSubview(sectionLabel)
        sectionLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    private func autoLayoutHorizontalController() {
        addSubview(horizontalController.view)
        horizontalController.view.anchor(top: sectionLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
}
