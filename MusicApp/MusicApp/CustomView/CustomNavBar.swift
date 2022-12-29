//
//  CustomNavBar.swift
//  MusicApp
//
//  Created by Frédéric Helfer on 21/12/22.
//

import UIKit

class CustomNavBar: UIView {
    
    lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var featureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    lazy var cardImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    lazy var overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.7)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomNavBar {
    
    private func setupView() {
        addSubview(cardImage)
        addSubview(overlayView)
        addSubview(categoryTitle)
        addSubview(cardTitle)
        addSubview(featureLabel)
    }
    
    private func setupConstraints() {
        cardImage.pin(to: self)
        overlayView.pin(to: self)
        
        NSLayoutConstraint.activate([
        
            categoryTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            categoryTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            categoryTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            cardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardTitle.topAnchor.constraint(equalTo: categoryTitle.bottomAnchor, constant: 5),
            
            featureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            featureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            featureLabel.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 5),
            
            
        ])
    }
    
}

extension CustomNavBar {
    
    public func setupView(data: CardViewModel) {
        cardTitle.text = data.cardTitle
        categoryTitle.text = data.categoryName
        cardImage.image = UIImage(named: data.cardImage ?? "")
        featureLabel.attributedText = .featureText(data.likeCount ?? "", data.duration ?? "")
    }
    
}
