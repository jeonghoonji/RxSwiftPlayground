//
//  LoginService.swift
//  RxSwiftPratice
//
//  Created by 지정훈 on 7/7/24.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case requestFailed(Error)
}
class LoginService {
    
    static let shared = LoginService()
    
    func login(completion: @escaping (Result<Login, NetworkError>) -> Void) {
        // URL 유효성 검사
        guard let url = URL(string: "https://mocki.io/v1/00f35d0f-f866-4475-9ca4-a28019029d72") else {
            completion(.failure(.invalidURL))
            return
        }
        
        AF.request(url).response { response in
            // 요청 오류
            if let error = response.error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            // 데이터 유효성 검사
            guard let data = response.data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                // 변환 과정 성공
                let loginResponse = try JSONDecoder().decode(Login.self, from: data)
                completion(.success(loginResponse))
            } catch {
                // 변환 과정 오류
                completion(.failure(.decodingError(error)))
            }
        }
    }
}
