//
//  SearchResultCollectionCell.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 4.02.2023.
//

import UIKit

class SearchResultCollectionCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let reuseIdentifier = "SearchResultCollectionCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.text = "Instagram"
        name.textColor = .black
        name.font = .systemFont(ofSize: 18, weight: .regular)
        return name
    }()
    
    let categoryLabel: UILabel = {
        let category = UILabel()
        category.text = "Photos & Videos"
        category.textColor = .black
        category.font = .systemFont(ofSize: 16, weight: .regular)
        return category
    }()
    
    let ratingsLabel: UILabel = {
        let ratings = UILabel()
        ratings.text = "9.26M"
        ratings.textColor = .lightGray
        ratings.font = .systemFont(ofSize: 14, weight: .regular)
        return ratings
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .heavy)
        button.backgroundColor = .init(white: 0.96, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()
    
    lazy var screenshot1ImageView = self.createScreenshotImageView()
    lazy var screenshot2ImageView = self.createScreenshotImageView()
    lazy var screenshot3ImageView = self.createScreenshotImageView()

    //MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        autoLayoutFullStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Helpers
    
    private func createScreenshotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
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
    private func autoLayoutFullStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            imageView, autoLayoutLabelsStackView(), getButton
        ])
        
        stackView.spacing = 16
        stackView.alignment = .center
        
        let fullStackView = VerticalStackView(arrangedSubviews: [stackView, autoLayoutImagesStackView()], spacing: 12)
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(fullStackView)
        
        fullStackView.fillSuperview(padding: .init(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    private func autoLayoutImagesStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [
            screenshot1ImageView, screenshot2ImageView, screenshot3ImageView
        ])
        
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        return stackView
    }
    
    //MARK: - Configure
    func configure(with model: SearchResult) {
        let rating = String(format: "%.2f", model.averageUserRating ?? 0.0)
        nameLabel.text = model.trackName
        categoryLabel.text = model.primaryGenreName
        ratingsLabel.text = "Ratings: \(rating)"
        imageView.downloadedFrom(url: model.artworkUrl100)
        screenshot1ImageView.downloadedFrom(url: model.screenshotUrls[0])
        screenshot2ImageView.downloadedFrom(url: model.screenshotUrls[1])
        screenshot3ImageView.downloadedFrom(url: model.screenshotUrls[2])
    }
}
