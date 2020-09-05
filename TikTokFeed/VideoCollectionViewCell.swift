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
    l.textAlignment = .left
    l.textColor     = .label
    return l
  }()
  private lazy var audioLabel : UILabel = {
    let l = UILabel()
    l.textAlignment = .left
    l.textColor     = .label
    return l
  }()
  
  private lazy var userNameLabel : UILabel = {
    let l = UILabel()
    l.textAlignment = .left
    l.textColor     = .label
    return l
  }()
  
  private lazy var profileButton : UIButton = {
    let b = UIButton(type: .system)
    b.setImage(UIImage(systemName: "person.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
    b.tintColor = .white
    return b
  }()
  private lazy var commentButton : UIButton = {
    let b = UIButton(type: .system)
    b.setImage(UIImage(systemName: "text.bubble")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
    b.tintColor = .white
    return b
  }()
  private lazy var shareButton : UIButton = {
    let b = UIButton(type: .system)
    b.setImage(UIImage(systemName: "square.and.arrow.up.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
    b.tintColor = .white
    return b
  }()
  private lazy var likeButton : UIButton = {
    let b = UIButton(type: .system)
    b.setImage(UIImage(systemName: "heart.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
    b.tintColor = .white
    return b
  }()
  
  // MARK: Stacks
  
  private var labelsStack : UIStackView = {
    let stack = UIStackView()
    stack.axis         = .vertical
    stack.distribution = .fillEqually
    stack.spacing      = 5
    return stack
  }()
  
  private var buttonStack : UIStackView = {
    let stack = UIStackView()
    stack.axis         = .vertical
    stack.distribution = .fillEqually
    stack.spacing      = 5
    return stack
  }()
  
  
  // MARK: - CLousers
  
  var didTapProfileButton : ((VideoModel) -> Void)?
  var didTapShareButton   : ((VideoModel) -> Void)?
  var didTapCommentButton : ((VideoModel) -> Void)?
  var didTapLikeButton    : ((VideoModel) -> Void)?
  
  // MARK: - Properties
  
  private var player : AVPlayer?
  var model          : VideoModel?
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    [profileButton,commentButton,shareButton,likeButton].forEach{
      $0.addTarget(self, action: #selector(handleTapButtons), for: .touchUpInside)
    }
    backgroundColor = .black
    setUpViews()
  }
  
  @objc private func handleTapButtons(button: UIButton) {
    guard let model = self.model else {return}
    switch button {
    case profileButton:
      
      didTapProfileButton!(model)
    case commentButton:
      didTapCommentButton!(model)
    case shareButton:
      didTapShareButton!(model)
    case likeButton:
      didTapLikeButton!(model)
    default:break
    }
  }
  
  
  // MARK: - SetUpView
  
  
  private func setUpViews() {
    playerView.frame = contentView.bounds
    contentView.layer.addSublayer(playerView)
    configureLabels()
    configureButtons()
    
    
  }
  
  private func configureLabels() {
    labelsStack.addArrangedSubview(captionLabel)
    labelsStack.addArrangedSubview(audioLabel)
    labelsStack.addArrangedSubview(userNameLabel)
    
    contentView.addSubview(labelsStack)
    
    labelsStack.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 20, bottom: 120, right: 0))
    labelsStack.constrainWidth(constant: contentView.frame.size.width / 2.5)
  }
  
  private func configureButtons() {
    buttonStack.addArrangedSubview(likeButton)
    buttonStack.addArrangedSubview(shareButton)
    buttonStack.addArrangedSubview(profileButton)
    buttonStack.addArrangedSubview(commentButton)
    
    contentView.addSubview(buttonStack)
    buttonStack.anchor(top: nil, leading: nil, bottom: labelsStack.topAnchor, trailing: contentView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 10, right: 10))
    buttonStack.constrainHeight(constant: contentView.frame.size.height / 2)
//    buttonStack.constrainWidth(constant: contentView.frame.size.width / 5)
//    buttonStack.centerYInSuperview()
  }
  
  // MARK: - Prepare For Reuse
  
  override func prepareForReuse() {
    super.prepareForReuse()
    captionLabel.text  = nil
    userNameLabel.text = nil
    audioLabel.text    = nil
  }
  
  // MARK: - Confure
  func configure(with model: VideoModel) {
    self.model = model
    confureVideo(model: self.model)
    
    captionLabel.text  = model.caption
    userNameLabel.text = model.userName
    audioLabel.text    = model.audioTrackName
    
  }
  
  
  private func confureVideo(model: VideoModel?) {
    guard
      let model = model,
      let path  = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat)
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
