//
//  SignInViewController.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import UIKit

class SignInViewController: UIViewController {

    static let name = "SignInViewController"

    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var signInButton: UIButton!

    var presenter: SignInPresenter!

    var onSignInSuccess: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction private func userNameChanged(_ sender: Any) {
        presenter.userName = userNameTextField.text
    }

    @IBAction private func signInTapped(_ sender: Any) {
        errorLabel.isHidden = true
        activityIndicator.startAnimating()
        presenter.signIn()
    }
}

extension SignInViewController: SignInViewDelegate {
    func signInSuccess() {
        activityIndicator.stopAnimating()
        onSignInSuccess?()
    }

    func signInFailure() {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
    }

    func signInError() {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
    }
}
