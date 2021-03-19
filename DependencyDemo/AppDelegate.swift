//
//  AppDelegate.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import UIKit
import Resolver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    @Injected private var navigator: AppNavigator

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let rootViewController = navigator.initialize()

        window = UIWindow()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        UserDefaults.standard.synchronize()
    }
}
