//
//  SignOutCommand.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import Foundation

protocol SignOutCommand {
    func signOut()
}


class SignOutCommandImpl: SignOutCommand {
    let cognitoService: CognitoService
    let userRepository: UserRepository

    init(cognitoService: CognitoService,
         userRepository: UserRepository) {
        self.cognitoService = cognitoService
        self.userRepository = userRepository
    }

    func signOut() {
        cognitoService.signOut()

        if let clearable = userRepository as? ICachingDecorator {
            clearable.clear()
        }
    }
}
