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
    
    var title: String {
        
        switch self {
        case .debug: return "DEBUG"
        case .error: return "ERROR"
        case .warning: return "WARNING"
        case .success: return "SUCCESS"
        case .action: return "ACTION"
        case .custom: return "CUSTOM"
        }
        
    }
    
    var emoji: String {
        
        switch self {
        case .debug: return "🐛🐛🐛🐛"
        case .error: return "❌❌❌❌"
        case .warning: return "⚠️⚠️⚠️⚠️"
        case .success: return "✅✅✅✅"
        case .action: return "🔫🔫🔫🔫"
        case .custom(let emoji): return String.init(repeating: emoji, count: 4)
        }
        
    }
    
}

protocol LoggerServiceProtocol: AnyObject {
    
    func log(_ logType: LogType, _ message: String)
    
}

class LoggerService: LoggerServiceProtocol {
    
    func log(_ logType: LogType, _ message: String) {
        
        var log: String = ""
        let emojiMessage: String = "\n \(logType.emoji) \(logType.title)"
        
        switch logType {
        case .success, .action:
            
            log += emojiMessage
            log += " \(message) \n"
        
        case .custom(let customMessage):
            
            log += emojiMessage
            log += " \(customMessage) \n"
            
        default:
            
            let fileName = #file.components(separatedBy: "/").last ?? ""
            log = "\n \(Date()) "
            log += emojiMessage
            log += "\n FILE: \(fileName) \n ➡️ LINE: \(#line) \n ➡️ FUNC: \(#function) \n 💬 MESSAGE: \(message) \n"
            
        }
        
        print(log)

    }
    
}
