//
//  File.swift
//  LootPop
//
//  Created by Sako Hovaguimian on 9/17/21.
//

import UIKit

enum LPColor: String {
    
    case lightWhiteBlue = "#e1f5f2"
    case lightPink = "#f5edf0"
    case lightPurple = "#c5b0e8"
    case lightBlue = "#92b4f4"
    
    public var color: UIColor {
        return UIColor(hex: self.rawValue)!
    }
    
}

