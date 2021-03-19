//
//  HomeViewController.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import UIKit

class HomeViewController: UIViewController {

    static let name = "HomeViewController"

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    var presenter: HomePresenter!

    var onSignOut: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(signOutTapped))

        presenter.attachedToView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @objc func signOutTapped(_ sender: Any) {
        onSignOut?()
    }
}

extension HomeViewController: HomeViewDelegate {
    func loadingImage() {
        activityIndicator.startAnimating()
    }

    func loadedImage(url: URL?) {
        activityIndicator.stopAnimating()
        if let url = url {
            imageView.load(url: url)
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
