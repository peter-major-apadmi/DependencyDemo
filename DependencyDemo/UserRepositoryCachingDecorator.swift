//
//  UserRepository.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import Foundation

class UserRepositoryCachingDecorator: UserRepository, ICachingDecorator {
    private let userRepository: UserRepository
    private var cachedImageUrl: URL?

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func getImageUrl(completionHandler: @escaping (URL?) -> Void) {
        if let url = cachedImageUrl {
            completionHandler(url)
            return
        }
        userRepository.getImageUrl { [weak self] url in
            self?.cachedImageUrl = url
            completionHandler(url)
        }
    }

    func clear() {
        cachedImageUrl = nil
    }
}

protocol ICachingDecorator {
    func clear()
}
