//
//  AppDelegate.swift
//  SampleChaos
//
//  Created by Alexander Ivlev on 09/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import UIKit
import DITranquillity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func applicationDidFinishLaunching(_ application: UIApplication) {
    window = UIWindow(frame: UIScreen.main.bounds)

		let builder = DIContainerBuilder()
		builder.register(module: Module1())
		builder.register(component: SampleStartupComponent())
		
		let container = try! builder.build()
		
    let storyboard = DIStoryboard(name: "Main", bundle: nil, container: container)
    window!.rootViewController = storyboard.instantiateInitialViewController()

    window!.makeKeyAndVisible()
  }
}

