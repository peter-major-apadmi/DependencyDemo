//
//  AppDelegate.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigator: AppNavigator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let settings = SettingsImpl(userDefaults: UserDefaults.standard)
        navigator = AppNavigatorImpl(settings: settings)
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
