//
//  AppDelegate.swift
//  ShoppingApp
//
//  Created by Erdem Perşembe on 12.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        let rootViewController = MainPageBuilder.build()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        return true
    }
}

