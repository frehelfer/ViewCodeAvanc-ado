//
//  DetailVC.swift
//  MusicApp
//
//  Created by Frédéric Helfer on 15/12/22.
//

import UIKit

enum StateAnimation {
    case long, short
}

class DetailVC: UIViewController {
    
    var detailView: DetailView?
    
    var cardModel = CardViewModel()
    
    var valueAnimation: StateAnimation = .long

    override func loadView() {
        self.detailView = DetailView(dataView: self.cardModel)
        self.view = detailView
        self.detailView?.configAllDelegates(tableViewDelegate: self, tableViewDataSource: self, scrollViewDelegate: self, detailViewDelegate: self)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func animationWithView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let window = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).compactMap({$0 as? UIWindowScene}).first?.windows.filter({$0.isKeyWindow}).first
        
        let topPadding = window?.safeAreaInsets.top
        print(scrollView.contentOffset.y)
        
        if scrollView.contentOffset.y >= 300 {
            self.detailView?.navBarTopAnchor?.constant = 0
            
            if valueAnimation == .long {
                animationWithView()
            }
            valueAnimation = .short
            
            
        } else {
            self.detailView?.navBarTopAnchor?.constant = -((topPadding ?? 0.0) + 80)
            
            if valueAnimation == .short {
                animationWithView()
            }
            valueAnimation = .long
        }
    }
    
}

extension DetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardModel.cardList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath) as? DetailCell else { fatalError("error") }
        cell.setupCell(data: cardModel.cardList?[indexPath.row] ?? CardListModel())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailView?.playerView.setupView(data: cardModel.cardList?[indexPath.row] ?? CardListModel())
        detailView?.playerViewBottomAnchor?.constant = 0
        animationWithView()
    }
    
}

extension DetailVC: UIScrollViewDelegate {
    

    
}

extension DetailVC: DetailViewDelegate {
    func tappedCloseButton() {
        self.dismiss(animated: true)
    }
    
    
}
