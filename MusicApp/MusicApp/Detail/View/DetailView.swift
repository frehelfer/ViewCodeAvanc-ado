//
//  DetailView.swift
//  MusicApp
//
//  Created by Frédéric Helfer on 15/12/22.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    func tappedCloseButton()
}

class DetailView: UIView {
    
    private weak var delegate: DetailViewDelegate?
    
    var cardModel: CardViewModel?
    var navBarTopAnchor: NSLayoutConstraint?
    var playerViewBottomAnchor: NSLayoutConstraint?

    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.autoresizingMask = .flexibleHeight
        view.bounces = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var cardView: CustomCardView = {
        let card = CustomCardView(mode: .full)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.cardContainerView.layer.cornerRadius = 0.0
        card.setupView(data: self.cardModel ?? CardViewModel())
        return card
    }()
    
    lazy var navBar: CustomNavBar = {
        let nav = CustomNavBar()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backgroundColor = .black
        nav.setupView(data: self.cardModel ?? CardViewModel())
        return nav
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tableFooterView = UIView()
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = false
        view.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        view.register(DetailCell.self, forCellReuseIdentifier: DetailCell.identifier)
        return view
    }()
    
    lazy var closeBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white.withAlphaComponent(0.3)
        btn.layer.cornerRadius = 15
        btn.setBackgroundImage(UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(tappedCloseBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var playerView: CustomPlayerView = {
        let pv = CustomPlayerView()
        pv.translatesAutoresizingMaskIntoConstraints = false
        return pv
    }()
    
    @objc func tappedCloseBtn() {
        self.delegate?.tappedCloseButton()
    }
    
    init(dataView: CardViewModel?) {
        super.init(frame: CGRect())
        self.cardModel = dataView
        
        DispatchQueue.main.async {
            self.setupViews()
            self.setupConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(cardView)
        scrollView.addSubview(tableView)
        addSubview(navBar)
        addSubview(closeBtn)
        addSubview(playerView)
    }
    
    private func setupConstraints() {
        let window = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).compactMap({$0 as? UIWindowScene}).first?.windows.filter({$0.isKeyWindow}).first
        
        let topPadding = window?.safeAreaInsets.top
        print(topPadding as Any)
        
        self.scrollView.pin(to: self)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -(topPadding ?? 0)),
            cardView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 500),
            cardView.widthAnchor.constraint(equalToConstant: self.frame.size.width),
            
            tableView.topAnchor.constraint(equalTo: cardView.bottomAnchor),
            tableView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(80 * (cardModel?.cardList?.count ?? 0) + 20)),
            tableView.widthAnchor.constraint(equalToConstant: self.frame.size.width),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            closeBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            closeBtn.widthAnchor.constraint(equalToConstant: 30),
            closeBtn.heightAnchor.constraint(equalToConstant: 30),
            closeBtn.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: ((topPadding ?? 0) + 80)),
            
            playerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 120),
            
        ])
        
        self.navBarTopAnchor = self.navBar.topAnchor.constraint(equalTo: topAnchor, constant: -((topPadding ?? 0) + 60))
        self.navBarTopAnchor?.isActive = true
        
        self.playerViewBottomAnchor = self.playerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 120)
        self.playerViewBottomAnchor?.isActive = true
    }
    
    public func configAllDelegates(tableViewDelegate: UITableViewDelegate, tableViewDataSource: UITableViewDataSource, scrollViewDelegate: UIScrollViewDelegate, detailViewDelegate: DetailViewDelegate) {
        self.tableView.delegate = tableViewDelegate
        self.tableView.dataSource = tableViewDataSource
        self.scrollView.delegate = scrollViewDelegate
        self.delegate = detailViewDelegate
    }
    
}
