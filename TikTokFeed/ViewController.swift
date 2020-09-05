//
//  ViewController.swift
//  TikTokFeed
//
//  Created by Павел Мишагин on 05.09.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import UIKit


// MARK: - Model
struct VideoModel {
  
  let caption         : String
  let userName        : String
  let audioTrackName  : String
  let videoFileName   : String
  let videoFileFormat : String
}

class ViewController: UIViewController {
  
  // MARK: - Views
  
  private lazy var collectionView : UICollectionView = {
    
    let layout  = UICollectionViewFlowLayout()
    
    layout.scrollDirection  = .vertical
    layout.itemSize         = .init(width: view.frame.size.width, height: view.frame.size.height)
    layout.sectionInset     = .init(top: 0, left: 0, bottom: 0, right: 0 )
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .black
    collectionView.isPagingEnabled = true
    collectionView.dataSource = self
    collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifer)
    return collectionView
  }()
  
  // MARK: - Data
  
  var data : [VideoModel] = []
  
  
  // MARK: - Lyfe Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpViews()
    addData()
  }
  
  
  private func setUpViews() {
    view.addSubview(collectionView)

    collectionView.fillSuperview()
    
  }
  
  private func addData() {
    
    (0...10).forEach { (_) in
      let model = VideoModel.init(caption: "This is a smiled video", userName: "My Self", audioTrackName: "Smile Mult", videoFileName: "test", videoFileFormat: "mp4")
      
      data.append(model)
    }
  }


}

// MARK: - CollectionView DataSource
extension ViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let item = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifer, for: indexPath) as! VideoCollectionViewCell
    
    let model = data[indexPath.item]
    item.configure(with: model)
    return item
  }
  
  
  
  
}


// MARK: - Swift UI Proiver

import SwiftUI
struct SwiftUIProvider: PreviewProvider {
  static var previews: some View {
    ContainerView().edgesIgnoringSafeArea(.all)
  }
  
  struct ContainerView: UIViewControllerRepresentable {
    
    let someVC = ViewController()
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SwiftUIProvider.ContainerView>) -> ViewController {
      return someVC
    }
    
    func updateUIViewController(_ uiViewController: SwiftUIProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SwiftUIProvider.ContainerView>) {
      
    }
  }
}
