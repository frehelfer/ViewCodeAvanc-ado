//
//  DetailTableView.swift
//  MusicApp
//
//  Created by Frédéric Helfer on 15/12/22.
//

import UIKit

class DetailTableView: UIView {

    lazy var thumbImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "demo")
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Teste"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Subtitulo"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var likeBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundImage(UIImage(named: "love")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .lightGray
        return btn
    }()
    
    lazy var moreBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundImage(UIImage(named: "more")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .lightGray
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailTableView {
    func setupViews() {
        addSubview(thumbImage)
        addSubview(moreBtn)
        addSubview(likeBtn)
        addSubview(title)
        addSubview(subTitle)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            thumbImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            thumbImage.widthAnchor.constraint(equalToConstant: 60),
            thumbImage.heightAnchor.constraint(equalToConstant: 60),
            
            moreBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            moreBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            moreBtn.widthAnchor.constraint(equalToConstant: 35),
            moreBtn.heightAnchor.constraint(equalToConstant: 35),
            
            likeBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            likeBtn.trailingAnchor.constraint(equalTo: moreBtn.leadingAnchor, constant: -15),
            likeBtn.widthAnchor.constraint(equalToConstant: 35),
            likeBtn.heightAnchor.constraint(equalToConstant: 35),
            
            title.leadingAnchor.constraint(equalTo: thumbImage.trailingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: likeBtn.leadingAnchor, constant: -15),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 17),
            
            subTitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subTitle.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            
        ])
    }
}

extension DetailTableView {
    public func setupCell(data: CardListModel) {
        thumbImage.image = UIImage.init(named: data.listImage ?? "")
        title.text = data.listTitle
        subTitle.text = data.listSubtitle
    }
}
