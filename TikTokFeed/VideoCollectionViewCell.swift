//
//  VideoCollectionViewCell.swift
//  TikTokFeed
//
//  Created by Павел Мишагин on 05.09.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import UIKit
import AVFoundation



class VideoCollectionViewCell: UICollectionViewCell {
  
  static let identifer = "VideoCollectionViewCell"
  
  // MARK: - Views
  
  private lazy var playerView : AVPlayerLayer = {
    let playerView = AVPlayerLayer()

    playerView.videoGravity = .resizeAspectFill
    return playerView
  }()
  
  
  private lazy var captionLabel : UILabel = {
    let l = UILabel()
    
    return l
  }()
  
  
  private var player : AVPlayer?
  
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .black
    setUpViews()
  }
  
  
  // MARK: - SetUpView
  
  
  private func setUpViews() {
    playerView.frame = contentView.bounds
    contentView.layer.addSublayer(playerView)
    
  }
  
  // MARK: - Confure
  func configure(with model: VideoModel) {
    confureVideo(model: model)
  }
  
  
  private func confureVideo(model: VideoModel) {
    guard
      let path = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat)
    else {return}
    
    let url = URL(fileURLWithPath: path)
    
    player = AVPlayer(url:url)
    playerView.player = player
    player?.volume = 0
    player?.play()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  
}
