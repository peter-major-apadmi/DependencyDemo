//
//  CognitoService.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import Foundation

protocol CognitoService {
    func signIn(userName: String, completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func signOut()
}

class CognitoServiceImpl: CognitoService {
    private let api: DogApi
    private let settings: Settings

    init(api: DogApi,
         settings: Settings) {
        self.api = api
        self.settings = settings
    }

    func signIn(userName: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        api.getImages(breed: userName) { [weak self] result in
            switch result {
            case .success(_):
                self?.settings.userName = userName
                completionHandler(.success(true))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    func signOut() {
        settings.userName = nil
    }
}
