//
//  SignInPresenter.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import Foundation

protocol SignInViewDelegate: AnyObject {
    func signInSuccess()
    func signInFailure()
    func signInError()
}

class SignInPresenter {
    private let cognitoService: CognitoService

    var userName: String?

    weak var viewDelegate: SignInViewDelegate?

    init(cognitoService: CognitoService) {
        self.cognitoService = cognitoService
    }

    func signIn() {
        guard let userName = userName else { return }

        cognitoService.signIn(userName: userName) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let success):
                if success {
                    self.viewDelegate?.signInSuccess()
                } else {
                    self.viewDelegate?.signInFailure()
                }

            case .failure(_):
                self.viewDelegate?.signInError()
            }
        }
    }
}
