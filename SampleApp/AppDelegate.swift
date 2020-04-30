//
//  AppDelegate.swift
//  SampleApp
//
//  Created by Frank on 2020/3/31.
//  Copyright © 2020 Frank. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = DashboardViewController()
        window!.rootViewController = UINavigationController(rootViewController: viewController)
        window!.makeKeyAndVisible()
        return true
    }

}

