//
//  LoginManager.swift
//  RxSwiftPratice
//
//  Created by 지정훈 on 7/7/24.
//

import Foundation

protocol LoginType{
    func getLoginInfo() -> [Login]
    func setLoginInfo(_ array: [Login])
}

final class LoginManager: LoginType {
    var currentLoginInfo: [Login] = []
    
    // 현재 로그인 정보 가져오기
    func getLoginInfo() -> [Login]{
        return currentLoginInfo
    }
    
    //로그인 정보 세팅하기
    func setLoginInfo(_ array: [Login]){
        self.currentLoginInfo = array
    }
}
