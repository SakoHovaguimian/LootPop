//
//  UserDefaultsService.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 9/17/21.
//

import Foundation

enum Key: String, CaseIterable {
    
    case theme
    case date
    case numberOfInteractions
    
}

protocol UserDefaultsServiceProtocol: AnyObject {
        
    func set(value: Any, for key: Key)
    func get(for key: Key) -> Any
    func remove(for key: Key)
    func clearAllKeys()
    
}

class UserDefaultsService: UserDefaultsServiceProtocol {
    
    private let loggerService: LoggerServiceProtocol!
        
    let userDefaults = UserDefaults.standard
    
    init(loggerService: LoggerServiceProtocol) {
        
        self.loggerService = loggerService
        self.loggerService.start(with: .userDefaults)
        
    }
    
    func set(value: Any, for key: Key) {
        self.userDefaults.set(value, forKey: key.rawValue)
    }
    
    func get(for key: Key) -> Any {
        self.userDefaults.string(forKey: key.rawValue) as Any
    }
    
    func remove(for key: Key) {
        self.userDefaults.removeObject(forKey: key.rawValue)
    }
    
    func clearAllKeys() {
        
        Key.allCases.forEach {
            remove(for: $0)
        }
        
    }
    
}
