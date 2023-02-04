//
//  AppsRowCollectionCell.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import UIKit

class AppsRowCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AppsRowCollectionCell"
    
    let imageView = UIImageView(cornerRadius: 8)
    
    let nameLabel = UILabel(font: .systemFont(ofSize: 16))
    let companyLabel = UILabel(font: .systemFont(ofSize: 14))
    
    let getButton = UIButton(title: "GET")
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        autoLayoutButton()
        autoLayoutImageView()
        autoLayoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        getButton.setTitleColor(.link, for: .normal)
        getButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .heavy)
        getButton.backgroundColor = UIColor(white: 0.96, alpha: 1)
        getButton.layer.cornerRadius = 32 / 2
    }
    
    private func autoLayoutView() {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4),
            getButton
        ])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    private func autoLayoutImageView() {
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    private func autoLayoutButton() {
        getButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        getButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    func configure(with model: FeedResult) {
        companyLabel.text = model.artistName
        nameLabel.text = model.name
        if let url = model.artworkUrl100 {
            imageView.downloadedFrom(url: url)
        } else {
            imageView.backgroundColor = .init(white: 0.96, alpha: 1)
        }
    }
}
