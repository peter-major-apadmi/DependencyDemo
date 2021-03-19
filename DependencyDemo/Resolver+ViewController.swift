//
//  Resolver+ViewController.swift
//  DependencyDemo
//
//  Created by Peter Major on 19/03/2021.
//

import Foundation

import Resolver

extension Resolver {

    private static var storyboard: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: nil)
    }()

    public static func registerViewControllers() {

        register {
            return HomePresenter(userRepository: resolve())
        }.scope(.unique)

        register(HomeViewController.self) {
            guard let viewController = storyboard.instantiateViewController(
                    withIdentifier: HomeViewController.name) as? HomeViewController else {
                fatalError("Unable to create HomeViewController")
            }
            return viewController
        }.resolveProperties { (resolver, viewController, _) in
            viewController.presenter = resolver.optional()
            viewController.presenter.viewDelegate = viewController
        }.scope(.unique)

        register {
            return SignInPresenter(cognitoService: resolve())
        }.scope(.unique)

        register(SignInViewController.self) {
            guard let viewController = storyboard.instantiateViewController(
                    withIdentifier: SignInViewController.name) as? SignInViewController else {
                fatalError("Unable to create SignInViewController")
            }
            return viewController
        }.resolveProperties { (resolver, viewController, _) in
            viewController.presenter = resolver.optional()
            viewController.presenter.viewDelegate = viewController
        }.scope(.unique)
    }
}
