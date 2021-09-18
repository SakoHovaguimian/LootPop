//
//  UIView+ext.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 8/10/21.
//

import UIKit

extension UIView {
    
    public enum Direction {
        case leftToRight, topToBottom
    }
    
    public func simpleGradient(colors: [UIColor], direction: Direction = .leftToRight) {
        
        self.layer.sublayers?.filter({$0.name == "MyGradient"}).forEach({$0.removeFromSuperlayer()})
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "MyGradient"
        gradientLayer.colors = colors.map({ $0.cgColor })
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = direction == .leftToRight ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func addTapGesture(action: @escaping UIGestureRecognizer.Action) {
        
        let recognizer = UITapGestureRecognizer(action: action)
        addGestureRecognizer(recognizer)
                
    }
    
}

public extension UIGestureRecognizer {
    
    typealias Action = (UIGestureRecognizer)->()
    
    private struct AssociatedKeys {
        static var action: UInt8 = 0
    }
    
    private var action: Action? {
        
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.action) as? Action else { return nil }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.action, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    convenience init(action: @escaping Action) {
        
        self.init()
        self.action = action
        
        self.addTarget(
            self,
            action: #selector(handleAction(_:))
        )
        
    }
    
    @objc private func handleAction(_ recognizer: UIGestureRecognizer) {
        action?(self)
    }
    
}
