//
//  UIView+ext.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 8/10/21.
//

import UIKit

extension UIView {
    
    public enum Direction {
        
        case leftToRight
        case topToBottom
        
    }
    
    public func simpleGradient(colors: [UIColor], direction: Direction = .leftToRight) {
        
        self.layer.sublayers?.filter({$0.name == "MyGradient"}).forEach({$0.removeFromSuperlayer()})
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "MyGradient"
        gradientLayer.colors = colors.map({ $0.cgColor })
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = direction == .leftToRight ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    public func simpleGradient(colors: [LPColor], direction: Direction = .leftToRight) {
        
        self.layer.sublayers?.filter({$0.name == "MyGradient"}).forEach({$0.removeFromSuperlayer()})
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "MyGradient"
        gradientLayer.colors = colors.map({ $0.color.cgColor })
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = direction == .leftToRight ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    public func addTapGesture(action: @escaping UIGestureRecognizer.Action) {
        
        let recognizer = UITapGestureRecognizer(action: action)
        addGestureRecognizer(recognizer)
                
    }
    
    public func addBlurView(style: UIBlurEffect.Style = .light,
                            alpha: CGFloat = 0.4) {
        
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = alpha
        self.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    public func addShadow(color: UIColor = .black,
                          opacity: Float = 1.0,
                          offset: CGSize = .zero,
                          radius: CGFloat = 2) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        
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
