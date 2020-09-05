//
//  AppDelegate.swift
//  TikTokFeed
//
//  Created by Павел Мишагин on 05.09.2020.
//  Copyright © 2020 Павел Мишагин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  
  var window : UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    root()
    return true
  }
  
  private func root() {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let vc = ViewController()
    
    window?.rootViewController = vc
    window?.makeKeyAndVisible()
  }



}

