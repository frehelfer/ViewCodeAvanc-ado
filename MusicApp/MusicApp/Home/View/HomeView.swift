//
//  HomeView.swift
//  MusicApp
//
//  Created by Frédéric Helfer on 13/12/22.
//

import UIKit

class HomeView: UIView {

    lazy var tableView: UITableView = {
        var tv = UITableView()
        tv.separatorStyle = .none
        tv.tableFooterView = UIView()
        tv.showsVerticalScrollIndicator = false
        tv.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        addSubview(tableView)
        self.tableView.pin(to: self)
    }
    
    public func configTableViewDelegate(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}
