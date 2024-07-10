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
    
    
    // output
    var isValid: Observable<Bool>{
        return Observable
            .combineLatest(idRelay,passwordRelay)
            .map{ id, password in
                return id.count >= 2 && password.count >= 2
            }
    }
    
    // output
    private let loginSuccessSubject = PublishSubject<Bool>()
    
    var loginSuccess: Observable<Bool>{
        return loginSuccessSubject.asObservable()
    }
    
    var loginSuccessIdLabel: Observable<String>{
        return loginSuccess
            .map{ [weak self] success in
                guard success, let loginInfo = self?.loginDataManager.getLoginInfo(), let id = loginInfo.first?.id else {
                    return "실패"
                }
                return "id : " + id
            }
    }
    var loginSuccessPasswordLabel: Observable<String>{
        return loginSuccess
            .map{ [weak self] success in
                guard success, let loginInfo = self?.loginDataManager.getLoginInfo(), let password = loginInfo.last?.password else {
                    return "실패"
                }
                return "password : " + password
            }
    }
    
    // 로그인 결과값 Manager을 통해 관리
    func login()  {
        loginService.login { result in
            switch result {
            case .success(let loginResponse):
                self.loginDataManager.setLoginInfo([loginResponse])
                self.loginSuccessSubject.onNext(true)
            case .failure(let error):
                print("Error: \(error)")
                self.loginSuccessSubject.onNext(false)
            }
        }
    }
}
