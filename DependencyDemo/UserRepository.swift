//
//  UserRepository.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import Foundation

protocol UserRepository {
    func getImageUrl(completionHandler: @escaping (URL?) -> Void)
}

class UserRepositoryImpl: UserRepository {
    private let api: DogApi
    private let settings: Settings

    init(api: DogApi,
         settings: Settings) {
        self.api = api
        self.settings = settings
    }

    func getImageUrl(completionHandler: @escaping (URL?) -> Void) {
        guard let userName = settings.userName else {
            completionHandler(nil)
            return
        }

        api.getImages(breed: userName) { result in
            switch result {
            case .success(let response):
                guard let first = response.message.first,
                      let url = URL(string: first) else {
                    completionHandler(nil)
                    return
                }
                completionHandler(url)
            case .failure(_):
                completionHandler(nil)
            }
        }
    }
}
