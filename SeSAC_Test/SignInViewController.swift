//
//  ViewController.swift
//  SeSAC_Test
//
//  Created by 김승찬 on 2021/12/27.
//

import UIKit

class SignInViewController: UIViewController {

    let mainView = SignInView()
    let viewModel = SignInViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        viewModel.username.bind { text in
            self.mainView.usernameTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        
        mainView.usernameTextField.addTarget(self, action: #selector(userNameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func userNameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }
    
    @objc func signInButtonClicked() {
        viewModel.postUserLogin {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                    return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }

    }

}

