//
//  HomeViewModel.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 4/24/21.
//

import UIKit
import RxSwift
import RxCocoa
import PromiseKit
import Alamofire

protocol HomeViewModelDelegate: AnyObject {

}

class HomeViewModel {

    private let apiService: APIServiceProtocol!
    private let alertService: AlertServiceProtocol!
    private let firebaseService: FirebaseServiceProtocol!
    
    private var _buttonText = BehaviorRelay<String>(value: "Submit")
    var buttonText: Observable<String> {
        return self._buttonText.asObservable()
    }
    
    private weak var delegate: HomeViewModelDelegate!
    
    init(apiService: APIServiceProtocol,
         alertService: AlertServiceProtocol,
         firebaseService: FirebaseServiceProtocol) {
        
        self.apiService = apiService
        self.alertService = alertService
        self.firebaseService = firebaseService
        
        loadData()
        
    }
    
    public func setup(delegate: HomeViewModelDelegate) -> Self {
        
        self.delegate = delegate
        return self
        
    }
    
    public func handleButtonTap() {
        self._buttonText.accept("Tapped Nice")
    }
    
    public func loadData() {
        
//        firebaseService.login(
//            email: "sako@airvet.com",
//            password: "123456"
//        )
//            .then { user -> Promise<String> in
//
//                print(user)
//                return self.firebaseService.getAccessTokenForCurrentUser(forceRefresh: false)
//
//            }
//            .done { token in
//                print(token)
//            }
//            .catch { error in
//                print(error)
//            }
        
        return
        
//        self.apiService.login()
//            .then { string -> Promise<Int> in
//                
//                return self.apiService.signUp()
//                
//            }
//            .then { number -> Promise<String> in
//                
//                return self.apiService.login()
//                
//            }
//            .done { _ in }
//            .catch { _ in
//                log(
//                    .debug,
//                    "Foudn this bug, champ"
//                )
//            }
        
    }
    
}
