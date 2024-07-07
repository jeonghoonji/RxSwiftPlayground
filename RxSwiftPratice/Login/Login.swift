//
//  Login.swift
//  RxSwiftPratice
//
//  Created by 지정훈 on 7/2/24.
//

import Foundation

struct Login: Codable{
    let id : String
    let password : String
}

struct LoginResponse {
    let sucess : Bool
}
