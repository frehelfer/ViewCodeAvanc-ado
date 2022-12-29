//
//  DetailCell.swift
//  MusicApp
//
//  Created by Frédéric Helfer on 15/12/22.
//

import UIKit

class DetailCell: UITableViewCell {
    
    static var identifier: String = "DetailCell"
    
    var screen = DetailTableView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailCell {
    func setupViews() {
        contentView.addSubview(screen)
    }
    
    func setupConstraints() {
        screen.pin(to: contentView)
    }
}

extension DetailCell {
    func setupCell(data: CardListModel) {
        screen.setupCell(data: data)
    }
}
