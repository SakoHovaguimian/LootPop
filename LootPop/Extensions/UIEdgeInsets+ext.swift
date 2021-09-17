//
//  UIEdgeInsets+ext.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 8/11/21.
//

import UIKit

enum Spacing {
    
    case none
    case small
    case medium
    case large
    case xLarge
    case custom(CGFloat)
    
    var value: CGFloat {
        
        switch self {
        case .none: return 0
        case .small: return 8
        case .medium: return 16
        case .large: return 32
        case .xLarge: return 48
        case .custom(let custom): return custom
        }
        
    }
    
}

extension UIEdgeInsets {
    
    static func inset(top: Spacing = .none,
                      left: Spacing = .none,
                      bottom: Spacing = .none,
                      right: Spacing = .none) -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: top.value,
            left: left.value,
            bottom: bottom.value,
            right: right.value
        )
        
    }
    
    static func inset(_ inset: Spacing) -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: inset.value,
            left: inset.value,
            bottom: inset.value,
            right: inset.value
        )
        
    }
    
    static func inset(vertical: Spacing = .none,
                      horizontal: Spacing = .none) -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: vertical.value,
            left: horizontal.value,
            bottom: vertical.value,
            right: horizontal.value
        )
        
    }
    
}
