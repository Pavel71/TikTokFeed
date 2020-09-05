//
//  ViewController.swift
//  TikTokFeed
//
//  Created by Павел Мишагин on 05.09.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green
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
