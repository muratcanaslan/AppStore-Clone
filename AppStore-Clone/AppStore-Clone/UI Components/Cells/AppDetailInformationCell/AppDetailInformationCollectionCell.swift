//
//  AppDetailInformationCollectionCell.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 18.02.2023.
//

import UIKit

class AppDetailInformationCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AppDetailInformationCollectionCell"
    
    let appIcon = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(font: .systemFont(ofSize: 24, weight: .medium), numberOfLines: 2)
    let descriptionLabel = UILabel(textColor: .gray, font: .systemFont(ofSize: 16, weight: .light))
    let priceButton = UIButton(title: "$4.99")
    let whatsNewLabel = UILabel(font: .systemFont(ofSize: 20))
    let versionLabel = UILabel(textColor: .gray, font: .systemFont(ofSize: 16, weight: .light))
    let releaseNotesLabel = UILabel(font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        autoLayoutStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        whatsNewLabel.text = "What's New"
        priceButton.backgroundColor = .link
        priceButton.layer.cornerRadius = 16
        priceButton.setTitleColor(.white, for: .normal)
        
        appIcon.constrainWidth(constant: 112)
        appIcon.constrainHeight(constant: 112)
        priceButton.constrainWidth(constant: 64)
        priceButton.constrainHeight(constant: 32)
    }
    
    private func autoLayoutStackView() {
        let stackView = VerticalStackView(
            arrangedSubviews: [
                autoLayoutHeaderStackView(),
                whatsNewLabel,
                versionLabel,
                releaseNotesLabel
            ],
            spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    private func autoLayoutHeaderStackView() -> UIStackView {
        let verticalStackView = VerticalStackView(arrangedSubviews: [nameLabel, descriptionLabel, priceButton], spacing: 8)

        verticalStackView.alignment = .leading
        let stackView = UIStackView(arrangedSubviews: [
            appIcon, verticalStackView
        ])
        stackView.spacing = 12
        stackView.alignment = .center
        return stackView
    }
    
    func configure(with model: SearchResult) {
        nameLabel.text = model.trackName
        descriptionLabel.text = model.description
        appIcon.downloadedFrom(url: model.artworkUrl100)
        releaseNotesLabel.text = model.releaseNotes
        versionLabel.text = "1.0.9"
        priceButton.setTitle(model.formattedPrice, for: .normal)
    }
}
