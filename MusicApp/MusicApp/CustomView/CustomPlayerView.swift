//
//  CustomPlayerView.swift
//  MusicApp
//
//  Created by Frédéric Helfer on 29/12/22.
//

import UIKit
import MarqueeLabel

class CustomPlayerView: UIView {
    
    var videoTimer: Timer?
    var time: CGFloat = 0.0
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        return img
    }()
    
    lazy var marqueeLabel: MarqueeLabel = {
        let l = MarqueeLabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Avenir-Heavy", size: 18)
        l.textColor = .white.withAlphaComponent(0.8)
        l.type = .continuous
        l.animationCurve = .linear
        l.fadeLength = 10.0
        l.leadingBuffer = 30.0
        l.trailingBuffer = 30.0
        return l
    }()
    
    lazy var pausePlayBtn: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "pause")?.withRenderingMode(.alwaysTemplate)
        img.tintColor = .white.withAlphaComponent(0.8)
        return img
    }()
    
    lazy var trackBar: UIProgressView = {
        let v = UIProgressView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.progressTintColor = .yellow.withAlphaComponent(0.8)
        v.progress = 0.0
        return v
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomPlayerView {
    
    func setupViews() {
        configSubView()
        configConstraints()
    }
    
    func configSubView() {
        addSubview(imageView)
        addSubview(marqueeLabel)
        addSubview(pausePlayBtn)
        addSubview(trackBar)
        
        self.videoTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.changeTrackBar), userInfo: nil, repeats: true)
    }
    
    @objc func changeTrackBar(){
        self.time += 0.001
        self.trackBar.progress = Float(self.time / 120)
        if self.time >= 120{
            self.videoTimer?.invalidate()
            self.videoTimer = nil
        }
    }
    
    func configConstraints() {
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 90),
            
            marqueeLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            marqueeLabel.trailingAnchor.constraint(equalTo: pausePlayBtn.leadingAnchor, constant: -5),
            marqueeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            
            pausePlayBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            pausePlayBtn.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            pausePlayBtn.heightAnchor.constraint(equalToConstant: 40),
            pausePlayBtn.widthAnchor.constraint(equalToConstant: 40),
            
            trackBar.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            trackBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            trackBar.topAnchor.constraint(equalTo: topAnchor),
        
        ])
    }
    
}

extension CustomPlayerView {
    
    public func setupView(data:CardListModel){
        self.imageView.image = UIImage(named: data.listImage ?? "")
        self.marqueeLabel.text = data.listTitle
        self.time = 0.0
        self.trackBar.progress = 0.0
        self.videoTimer = nil
        self.videoTimer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.changeTrackBar), userInfo: nil, repeats: true)
    }
    
}
