//
//  File.swift
//  LootPop
//
//  Created by Sako Hovaguimian on 9/17/21.
//

import UIKit

public enum LPColor: String {
    
    case lightWhiteBlue = "#e1f5f2"
    case lightPink = "#f5edf0"
    case lightPurple = "#c5b0e8"
    case lightBlue = "#92b4f4"
    
    // Brand
    
    case backgroundGray = "#E2E4E9"
    
    case brandPink = "#F39AAD"
    case brandYellow = "#FCFCD4"
    case brandBlue = "#9dceff"
    case brandWhite = "#F3F9FF"
    case brandBlack = "#404756"
    case brandPurple = "#9085e4"
    
    public var color: UIColor {
        return UIColor(hex: self.rawValue)!
    }
    
}

