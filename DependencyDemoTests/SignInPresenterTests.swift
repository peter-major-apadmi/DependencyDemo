//
//  SignInPresenterTests.swift
//  DependencyDemoTests
//
//  Created by Peter Major on 18/03/2021.
//

import Foundation
import XCTest
@testable import DependencyDemo

class SignInPresenterTests: XCTestCase {

    var cognitoService: CognitoServiceMock!
    var sut: SignInPresenter!

    override func setUp() {
        super.setUp()

        cognitoService = CognitoServiceMock()
        sut = SignInPresenter(cognitoService: cognitoService)
    }

    func testSignInWhenUserNameIsNil() {

        // Given
        //  userName has NOT been set
        sut.userName = nil

        // When
        //  signIn is called
        sut.signIn()

        // Then
        //  cognito service is NOT called
        XCTAssertEqual(cognitoService.signInCount, 0)
    }
}
