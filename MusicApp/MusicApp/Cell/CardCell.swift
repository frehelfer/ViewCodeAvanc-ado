//
//  CardCell.swift
//  MusicApp
//
//  Created by Frédéric Helfer on 13/12/22.
//

import UIKit

class CardCell: UITableViewCell {

    static let identifier = "CardCell"
    
    lazy var cardView: CustomCardView = {
        let view = CustomCardView(mode: .card)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupConstraints()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(cardView)
    }
    
    private func setupConstraints() {
        self.cardView.pin(to: self)
    }

}

extension CardCell {
    public func setupCell(data: CardViewModel) {
        cardView.setupView(data: data)
    }
}
