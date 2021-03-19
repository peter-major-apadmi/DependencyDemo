//
//  AppNavigator.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import UIKit

protocol AppNavigator {
    func initialize() -> UIViewController
}

class AppNavigatorImpl: AppNavigator {

    private let settings: Settings
    private var root: UINavigationController!

    private var storyboard: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: nil)
    }()

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
        guard let viewController = storyboard.instantiateViewController(
                withIdentifier: HomeViewController.name) as? HomeViewController else {
            fatalError("Unable to create HomeViewController")
        }

        let session = URLSession.shared
        let api = DogApiImpl(session: session)
        let userRepository = UserRepositoryImpl(api: api, settings: settings)
        let presenter = HomePresenter(userRepository: userRepository)
        presenter.viewDelegate = viewController

        viewController.presenter = presenter
        viewController.onSignOut = handleSignOut

        return viewController
    }

    private func createSignInViewController() -> SignInViewController {
        guard let viewController = storyboard.instantiateViewController(
                withIdentifier: SignInViewController.name) as? SignInViewController else {
            fatalError("Unable to create SignInViewController")
        }

        let session = URLSession.shared
        let api = DogApiImpl(session: session)
        let cognitoService = CognitoServiceImpl(api: api, settings: settings)
        let presenter = SignInPresenter(cognitoService: cognitoService)
        presenter.viewDelegate = viewController

        viewController.presenter = presenter
        viewController.onSignInSuccess = handleSignInSuccess

        return viewController
    }

    private func handleSignInSuccess() {
        let viewController = createHomeViewController()
        root.viewControllers = [viewController]
    }

    private func handleSignOut() {
        let session = URLSession.shared
        let api = DogApiImpl(session: session)
        let cognitoService = CognitoServiceImpl(api: api, settings: settings)
        let userRepository = UserRepositoryImpl(api: api, settings: settings)

        let signOutCommand = SignOutCommandImpl(
            cognitoService: cognitoService,
            userRepository: userRepository
        )
        signOutCommand.signOut()

        let viewController = createSignInViewController()
        root.viewControllers = [viewController]
    }

    private func isSignedIn() -> Bool {
        let userName = settings.userName
        return userName != nil
    }
}
