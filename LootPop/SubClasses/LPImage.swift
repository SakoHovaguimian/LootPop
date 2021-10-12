//
//  LPImage.swift
//  LootPop
//
//  Created by Sako Hovaguimian on 9/18/21.
//

import UIKit

enum LPImage: String {
    
    case home = "home"
    
    public var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
    
}
