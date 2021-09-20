//
//  FirebaseService.swift
//  LootPop
//
//  Created by Sako Hovaguimian on 9/19/21.
//

import Firebase
import RxCocoa
import RxSwift
import PromiseKit

protocol FirebaseServiceProtocol {
    
    var currentUser: User? { get }
    var currentAccessToken: Observable<String?> { get }
    
    func login(email: String, password: String) -> Promise<User>
    func signup(email: String, password: String) -> Promise<User>
    
    func getAccessTokenForCurrentUser(forceRefresh: Bool) -> Promise<String>
    func reloadCurrentUser() -> Promise<User>
    
    func updateName(name: String) -> Promise<Void>
    func updateEmail(email: String) -> Promise<Void>
    
    func logout()
    
}

class FirebaseService: FirebaseServiceProtocol {
    
    private let loggerService: LoggerServiceProtocol!

    var currentUser: User? {
        return Auth.auth().currentUser
    }
    
    private var _currentAccessToken = BehaviorRelay<String?>(value: nil)
    var currentAccessToken: Observable<String?> {
        return self._currentAccessToken.asObservable()
    }
    
    init(loggerService: LoggerServiceProtocol) {
        
        self.loggerService = loggerService
        self.loggerService.start(with: .firebase)
        
    }
    
    func login(email: String, password: String) -> Promise<User> {
                
        return Promise<User> { seal in
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if let error = error {
                    return seal.reject(error)
                }
                                                
                guard let user = result?.user else {
                    let err = self.error(message: "Firebase sign-in failed")
                    return seal.reject(err)
                }
                
                return seal.fulfill(user)
                
            }
            
        }
        
    }
    
    func signup(email: String, password: String) -> Promise<User> {
        
        return Promise<User> { seal in
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                if let error = error {
                    return seal.reject(error)
                }
                
                guard let user = result?.user else {
                    let err = self.error(message: "Firebase sign-up failed")
                    return seal.reject(err)
                }
                
                return seal.fulfill(user)
                
            }
            
        }
        
    }
    
    func getAccessTokenForCurrentUser(forceRefresh: Bool) -> Promise<String> {
        
        guard let user = Auth.auth().currentUser else {
            
            let message = "Attempting to fetch access token when no user is logged into Firebase"
            let error = self.error(message: message)
            return Promise<String>(error: error)
            
        }
        
        return Promise<String> { seal in
            
            user.getIDTokenResult(forcingRefresh: forceRefresh, completion: { (res, error) in
                
                if let err = error {
                    
                    self.loggerService.log("Firebase failed to retrieve access token")
                    return seal.reject(err)
                    
                }
                
                guard let token = res?.token else {
                    
                    let message = "Firebase failed to retrieve access token"
                    let err = self.error(message: message)
                    
                    self.loggerService.log(message)
                    
                    return seal.reject(err)
                    
                }
                
                self._currentAccessToken.accept(token)
                seal.fulfill(token)
                
            })
            
        }
        
    }
    
    func reloadCurrentUser() -> Promise<User> {
        
        return Promise<User> { seal in
            
            self.currentUser?.reload(completion: { error in
                
                if let error = error {
                    return seal.reject(error)
                }
                
                guard let user = self.currentUser else {
                    
                    let err = self.error(message: "Reload failed and this is a different user")
                    seal.reject(err)
                    return
                    
                }
                
                seal.fulfill(user)
                
            })
            
        }
        
    }
    
    func updateName(name: String) -> Promise<Void> {
        
        guard let user = self.currentUser else {
            
            let err = self.error(message: "No User is signed in")
            return Promise<Void>(error: err)
            
        }
        
        return Promise<Void> { seal in
            
            let req = user.createProfileChangeRequest()
            req.displayName = name
            req.commitChanges { err in
                
                if let err = err {
                    return seal.reject(err)
                }
                
                seal.fulfill(())
                
            }
            
        }
        
    }
    
    func updateEmail(email: String) -> Promise<Void> {
        
        guard let user = self.currentUser else {
            
            let err = self.error(message: "No User is signed in")
            return Promise<Void>(error: err)
            
        }
        
        return Promise<Void> { seal in

            user.updateEmail(to: email) { error in
                
                if let error = error {
                    return seal.reject(error)
                }
                
                seal.fulfill(())
                
            }
            
        }
        
    }
    
    private func error(message: String) -> Error {
        
        let info = Bundle.main.infoDictionary
        let bundleId = info?[kCFBundleIdentifierKey as String] as? String ?? "com.hovaguimiansako.lootpop"
        
        return NSError(
            domain: bundleId,
            code: 0,
            userInfo: [NSLocalizedDescriptionKey: message]
        )
        
    }
    
    func logout() {
        
        do {
            try Auth.auth().signOut()
        }
        catch(let error) {
            self.loggerService.log("logout failed: \(error.localizedDescription)")
        }
        
    }
    
}
