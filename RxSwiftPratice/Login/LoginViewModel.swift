//
//  LoginViewModel.swift
//  RxSwiftPratice
//
//  Created by 지정훈 on 7/2/24.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class LoginViewModel {
    
    let loginDataManager : LoginType
    let loginService : LoginService
    
    private let disposeBag = DisposeBag()
    
    init(loginDataManager: LoginType, loginService: LoginService) {
        self.loginDataManager = loginDataManager
        self.loginService = loginService
    }
    
    // Input
    let idRelay = BehaviorRelay<String>(value: "아이디 입력")
    let passwordRelay = BehaviorRelay<String>(value: "비밀번호 입력")
    
    var isValid: Observable<Bool>{
        return Observable
            .combineLatest(idRelay,passwordRelay)
            .map{ id, password in
                return id.count >= 2 && password.count >= 2
            }
    }
    
    func login()  {
        loginService.login { result in
            switch result {
            case .success(let loginResponse):
                self.loginDataManager.setLoginInfo([loginResponse])
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
