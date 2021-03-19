//
//  CognitoServiceMock.swift
//  DependencyDemoTests
//
//  Created by Peter Major on 18/03/2021.
//

import Foundation
@testable import DependencyDemo

class CognitoServiceMock: CognitoService {
    var signInUserName: String?
    var signInCount = 0
    var signInResult: Result<Bool, Error>?

    func signIn(userName: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        signInCount += 1
        signInUserName = userName
        completionHandler(signInResult!)
    }

    var signOutCount = 0

    func signOut() {
        signOutCount += 1
    }
}
