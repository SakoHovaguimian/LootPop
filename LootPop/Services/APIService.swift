//
//  APIService.swift
//  LootPop
//
//  Created by Sako Hovaguimian on 9/18/21.
//

import Alamofire
import PromiseKit

protocol APIServiceProtocol {
        
    func login() -> Promise<String>
    func signUp() -> Promise<Int>
    
}

class APIService: APIServiceProtocol {
        
    private let loggerService: LoggerServiceProtocol!
    
    init(loggerService: LoggerServiceProtocol) {
        
        self.loggerService = loggerService
        self.loggerService.start(with: .api)
        
    }
    
    func login() -> Promise<String> {
        return Promise<String>.value("")
    }
    
    func signUp() -> Promise<Int> {
        return Promise<Int>.value(0)
    }
    
}

//MARK:- Example Shit
//return Promise<String> { seal in
//
//    AF.request(
//        "www.google.com",
//        method: .post,
//        parameters: ["" : ""]
//    ).responseDecodable(
//        of: String.self) { result in
//            switch result.result {
//            case .success(_): seal.fulfill("Test")
//            case .failure(let error):
//               log(
//                    .error,
//                    "This is not working at all bro"
//                )
//                seal.reject(error)
//            }
//        }
//
//}
