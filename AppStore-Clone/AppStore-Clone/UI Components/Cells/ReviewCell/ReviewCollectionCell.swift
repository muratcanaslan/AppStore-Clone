//
//  ReviewCollectionCell.swift
//  AppStore-Clone
//
//  Created by Murat Can ASLAN on 19.02.2023.
//

import UIKit

class ReviewCollectionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ReviewCollectionCell"
    
    let titleLabel = UILabel(font: .systemFont(ofSize: 16, weight: .bold))
    let authorLabel = UILabel(textColor: .systemGray, font: .systemFont(ofSize: 16, weight: .regular))
    let bodyLabel = UILabel(font: .systemFont(ofSize: 16, weight: .regular), numberOfLines: 5)
    let starsStackView: UIStackView = {
        var arrangedSubviews = [UIView]()
        (0..<5).forEach({ _ in
            let image = UIImage(systemName: "star.fill")
            let imageView = UIImageView(image: image)
            imageView.tintColor = .orange
            imageView.constrainWidth(constant: 24)
            imageView.constrainHeight(constant: 24)
            arrangedSubviews.append(imageView)
        })
        arrangedSubviews.append(.init())
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.spacing = 8
        stackView.constrainHeight(constant: 24)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 16
        self.clipsToBounds = true
    }
    
    private func autoLayout() {
        let hStackView = UIStackView(arrangedSubviews: [titleLabel,
                                                        UIView(),
                                                        authorLabel])
        let stackView = VerticalStackView(
            arrangedSubviews: [
                hStackView,
                starsStackView,
                bodyLabel
            ],
            spacing: 12)
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
    }
    
    func configure(with model: Entry) {
        titleLabel.text = model.title.label
        bodyLabel.text = model.content.label
        authorLabel.text = model.author.name.label
        
        for (index, view) in starsStackView.arrangedSubviews.enumerated() {
            if let rating = Int(model.rating.label) {
                view.alpha = index >= rating ? 0.3 : 1
            }
        }
    }
}
