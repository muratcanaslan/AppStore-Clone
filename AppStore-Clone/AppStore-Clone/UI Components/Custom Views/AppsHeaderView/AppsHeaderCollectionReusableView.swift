//
//  AppsHeaderCollectionReusableView.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import UIKit

class AppsHeaderCollectionReusableView: UICollectionReusableView {
       
    static let reuseIdentiifer = "AppsHeaderCollectionReusableView"
    
    let horizontalController = AppsHeaderHorizontalViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(horizontalController.view)
        horizontalController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: [SocialApp]) {
        horizontalController.configure(with: model)
    }
}
