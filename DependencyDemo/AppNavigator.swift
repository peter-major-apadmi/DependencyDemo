//
//  AppNavigator.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import UIKit
import Resolver

protocol AppNavigator {
    func initialize() -> UIViewController
}

class AppNavigatorImpl: AppNavigator, Resolving {

    private let settings: Settings
    private var root: UINavigationController!

    init(settings: Settings) {
        self.settings = settings
    }

    func initialize() -> UIViewController {
        let viewController = isSignedIn()
            ? createHomeViewController()
            : createSignInViewController()

        root = UINavigationController(rootViewController: viewController)
        return root
    }

    private func createHomeViewController() -> HomeViewController {
        let viewController: HomeViewController = resolver.resolve()
        viewController.onSignOut = handleSignOut
        return viewController
    }

    private func createSignInViewController() -> SignInViewController {
        let viewController: SignInViewController = resolver.resolve()
        viewController.onSignInSuccess = handleSignInSuccess
        return viewController
    }

    private func handleSignInSuccess() {
        let viewController = createHomeViewController()
        root.viewControllers = [viewController]
    }

    private func handleSignOut() {
        let signOutCommand: SignOutCommand = resolver.resolve()
        signOutCommand.signOut()

        let viewController = createSignInViewController()
        root.viewControllers = [viewController]
    }

    private func isSignedIn() -> Bool {
        let userName = settings.userName
        return userName != nil
    }
}

/*
 NOTE: if you're a purist and you don't like the container framework "leaking" into your code,
       you could create an factory to hide the "Resolver" dependency

 protocol Factory {
     func create<T>(_ type: T.Type) -> T
 }

 class ResolverFactory: Factory, Resolving {
     func create<T>(_ type: T.Type) -> T {
         return resolver.resolve()
     }
 }
 */
