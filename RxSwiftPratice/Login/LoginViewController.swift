//
//  LoginViewController.swift
//  RxSwiftPratice
//
//  Created by 지정훈 on 7/2/24.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디를 입력해주세요"
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        
        button.isEnabled = false
        button.backgroundColor = .gray
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 10

        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var loginIdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var loginViewModel: LoginViewModel!
    let loginManger = LoginManager()
    let loginService = LoginService.shared
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        loginViewModel = LoginViewModel(loginDataManager: loginManger, loginService: loginService)
        
        configureUI()
        setUpAutoLayout()
        bindUI()
        
    }
    
    
    func configureUI(){
        [
            idTextField,
            passwordTextField,
            loginButton,
            loginIdLabel,
            loginPasswordLabel
        ].forEach{
            view.addSubview($0)
        }
      
        
    }
    func setUpAutoLayout(){
        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: view.topAnchor,constant: 80),
            idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            idTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            
            passwordTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor,constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 10),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            
            
            loginIdLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor,constant: 100),
            loginIdLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            loginIdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            
            loginPasswordLabel.topAnchor.constraint(equalTo: loginIdLabel.bottomAnchor,constant: 20),
            loginPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            loginPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            
            
        ])
    }
    func bindUI(){
        //input
        idTextField.rx.text.orEmpty.asObservable()
            .bind(to: loginViewModel.idRelay)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty.asObservable()
            .bind(to: loginViewModel.passwordRelay)
            .disposed(by: disposeBag)
    
        loginButton.rx.tap
            .withUnretained(self)
            .bind{ vc, _ in
                vc.loginViewModel.login()
            }
            .disposed(by: disposeBag)
        
        //output
        let isValid = loginViewModel.isValid
             .share()
         
         isValid
             .bind(to: loginButton.rx.isEnabled)
             .disposed(by: disposeBag)
         
         isValid
            .map { $0 == true ? .black : .gray }
             .bind(to: loginButton.rx.backgroundColor)
             .disposed(by: disposeBag)
        
        loginViewModel.loginSuccessIdLabel
            .bind(to: loginIdLabel.rx.text)
            .disposed(by: disposeBag)
        
        loginViewModel.loginSuccessPasswordLabel
            .bind(to: loginPasswordLabel.rx.text)
            .disposed(by: disposeBag)

    }
    
}


#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct LoginViewController_Preview: PreviewProvider {
    static var previews: some View {
        Group{
            LoginViewController().showPreview(.iPhone15Pro)
                .previewLayout(.sizeThatFits)
          
        }
        
    }
}
#endif
