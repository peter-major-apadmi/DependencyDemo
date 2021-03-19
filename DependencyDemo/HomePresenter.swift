//
//  HomePresenter.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func loadingImage()
    func loadedImage(url: URL?)
}

class HomePresenter {
    private let userRepository: UserRepository

    weak var viewDelegate: HomeViewDelegate?

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func attachedToView() {
        viewDelegate?.loadingImage()

        userRepository.getImageUrl { [weak self] url in
            self?.viewDelegate?.loadedImage(url: url)
        }
    }
}
