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
    let cachingDecorators: [ICachingDecorator]

    init(cognitoService: CognitoService,
         cachingDecorators: [ICachingDecorator]) {
        self.cognitoService = cognitoService
        self.cachingDecorators = cachingDecorators
    }

    func signOut() {
        cognitoService.signOut()

        cachingDecorators.forEach { $0.clear() }
    }
}
