//
//  SearchResultCollectionCell.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import UIKit

class SearchResultCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "SearchResultCollectionCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.text = "APP NAME"
        return name
    }()
    
    let categoryLabel: UILabel = {
        let category = UILabel()
        category.text = "Photos & Videos"
        return category
    }()
    
    let ratingsLabel: UILabel = {
        let ratings = UILabel()
        ratings.text = "9.26M"
        return ratings
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = .init(white: 0.98, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        
        autoLayoutTopStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    private func autoLayoutLabelsStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            categoryLabel,
            ratingsLabel
        ])
        
        stackView.spacing = 2
        stackView.axis = .vertical

        return stackView
        
    }
    private func autoLayoutTopStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            imageView, autoLayoutLabelsStackView(), getButton
        ])
        
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
