//
//  LoggerService.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 6/13/21.
//

import UIKit

enum LogType {
    
    case debug
    case error
    case warning
    case success
    case action
    case custom(String)
    
    case firebase
    case api
    case alert
    case userDefaults
    
    var title: String {
        
        switch self {
        case .debug: return "DEBUG"
        case .error: return "ERROR"
        case .warning: return "WARNING"
        case .success: return "SUCCESS"
        case .action: return "ACTION"
        case .custom: return "CUSTOM"
            
        // Services
            
        case .firebase: return "[FirebaseService] -"
        case .api: return "[APIService] -"
        case .alert: return "[AlertService] -"
        case .userDefaults: return "[UserDeafultsService] -"
        }
        
    }
    
    var emoji: String {
        
        switch self {
        case .debug: return "🐛🐛🐛🐛"
        case .error: return "❌❌❌❌"
        case .warning: return "⚠️⚠️⚠️⚠️"
        case .success: return "✅✅✅✅"
        case .action: return "🔫🔫🔫🔫"
        case .custom(let emoji): return String.init(repeating: emoji, count: 10)
            
        //Services
            
        case .firebase: return String.init(repeating: "🔥", count: 10)
        case .api: return String.init(repeating: "🌐", count: 10)
        case .alert: return String.init(repeating: "🚨", count: 10)
        case .userDefaults: return String.init(repeating: "🔒", count: 10)
        }
        
    }
    
}

protocol LoggerServiceProtocol {
    
    var logger: LogType? { get set }
    
    func start(with logType: LogType)
    func log(_ message: String)
    
}

class LoggerService: LoggerServiceProtocol {
    
    var logger: LogType?
    
    init() {
        print(String.init(repeating: "🪵", count: 10) + " [LogService] - STARTING UP")
    }

    func start(with logType: LogType) {

        self.logger = logType
        print("\(logType.emoji) \(logType.title) STARTING UP")

    }

    func log(_ message: String) {

        guard let logger = self.logger else { return }

        var log: String = "\n \n \n \(logger.emoji) \(logger.title)"
        log += " \(message)"

        print(log)

    }
    
}
