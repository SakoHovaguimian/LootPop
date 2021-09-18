//
//  ToastView.swift
//  Yeeb.fm
//
//  Created by Sako Hovaguimian on 10/5/20.
//

import UIKit
import SnapKit

import Foundation

struct Toast {
    
    enum Status {
        case normal
        case success
        case error
    }
    
    enum Duration {
        
        case seconds(TimeInterval)
        case untilDismissed
        
    }
    
    var title: String?
    var message: String
    var duration: Duration
    var status: Status
    var action: (()->())?
    
    init(title: String?,
         message: String,
         duration: Duration = .seconds(4),
         status: Status = .normal,
         action: (()->())?) {
        
        self.title = title
        self.message = message
        self.duration = duration
        self.status = status
        self.action = action
        
    }
    
    public func toastBackgroundColor() -> UIColor {
        switch self.status {
        case .normal: return .darkGray
        case .success: return .systemGreen
        case .error: return .systemRed
        }
    }
    
}

class ToastView: UIView {
    
    enum Direction {
        case top, bottom
    }

    private let toast: Toast
    private let direction: Direction
    
    private var toastContentView: UIView!
    private var toastTitleLabel: UILabel?
    private var toastMessageLabel: UILabel!
        
    private var dismissTimer: Timer?
    
    private var toastTopOffset: CGFloat {
        return 55
    }
    
    init(toast: Toast,
         direction: Direction = .top) {
        
        self.toast = toast
        self.direction = direction
        super.init(frame: .zero)
        setupSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        
        self.toastContentView = UIView()
        self.toastContentView.layer.cornerRadius = 8
        self.toastContentView.clipsToBounds = true
        self.toastContentView.isUserInteractionEnabled = true
        self.addSubview(self.toastContentView)
        
        if self.direction == .top {
            
            self.toastContentView.snp.makeConstraints { make in
                make.top.equalTo(self.toastTopOffset)
                make.left.equalTo(16)
                make.right.equalTo(-16)
                make.bottom.equalToSuperview()
            }
            
        }
        else {
            
            self.toastContentView.snp.makeConstraints { make in
                make.bottom.equalTo(-32)
                make.left.equalTo(16)
                make.right.equalTo(-16)
                make.top.equalToSuperview()
            }
            
        }
        
        //MARK:- ADD TAP GESTURE
        
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapToast(_:))
        )
        self.toastContentView.addGestureRecognizer(gesture)
        
        if self.direction == .top {
            
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp(_:)))
            swipe.direction = .up
            self.toastContentView.addGestureRecognizer(swipe)
            
        }
        else {
            
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown(_:)))
            swipe.direction = .down
            self.toastContentView.addGestureRecognizer(swipe)
            
        }
        
        if let title = self.toast.title {
            
            self.toastTitleLabel = UILabel()
            self.toastTitleLabel!.font = .boldSystemFont(ofSize: 20.0)
            self.toastTitleLabel!.textColor = .white
            self.toastTitleLabel!.text = title
            self.toastTitleLabel!.numberOfLines = 0
            self.toastContentView.addSubview(self.toastTitleLabel!)
            
            self.toastTitleLabel?.snp.makeConstraints { make in
                make.top.equalTo(16)
                make.left.equalTo(16)
                make.right.equalTo(-16)
            }
            
        }
        
        self.toastMessageLabel = UILabel()
        self.toastMessageLabel.font = .systemFont(ofSize: 16.0)
        self.toastMessageLabel.textColor = .white
        self.toastMessageLabel.text = self.toast.message
        self.toastMessageLabel.numberOfLines = 0
        self.toastContentView.addSubview(self.toastMessageLabel)
        
        let anchor = self.toastTitleLabel != nil ?
            self.toastTitleLabel :
            self.toastContentView
        
        let paddingTop: CGFloat = self.toastTitleLabel != nil ? 4.0 : 20
        
        self.toastMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(anchor!.snp.bottom).offset(paddingTop)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-16)
        }
        
        self.toastContentView.backgroundColor = self.toast.toastBackgroundColor()
        
    }
    
    @objc private func didTapToast(_ recognizer: UITapGestureRecognizer) {
        
        if let action = self.toast.action {
            
            action()
            self.hide()
            
        }
        
    }
    
    @objc private func didSwipeUp(_ recognizer: UISwipeGestureRecognizer) {
        self.hide()
    }
    
    @objc private func didSwipeDown(_ recognizer: UISwipeGestureRecognizer) {
        self.hide()
    }
        
    func show(from parentView: UIView, completion: (()->())? = nil) {
        
        parentView.addSubview(self)
        
        if self.direction == .top {
            
            self.snp.makeConstraints { make in
                make.top.equalTo(parentView.superview!.snp.top).offset(-16)
                make.left.equalTo(parentView.snp.left).offset(14)
                make.right.equalTo(parentView.snp.right).offset(-14)
                
            }
            
        }
        else {
            
            self.snp.makeConstraints { make in
                make.bottom.equalTo(parentView.superview!.snp.bottom).offset(-16)
                make.left.equalTo(parentView.snp.left).offset(14)
                make.right.equalTo(parentView.snp.right).offset(-14)
                
            }
            
        }
        
        let transform = (self.toastTopOffset + self.toastContentView.bounds.height)
        let directionTransform = self.direction == .top ? -transform : transform
        let startingTransform = CGAffineTransform(translationX: 0, y: directionTransform)

        self.toastContentView.alpha = 0.5
        self.toastContentView.transform = startingTransform
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.1,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 1.0,
            options: .curveEaseIn) {
            
            self.toastContentView.alpha = 1
            self.toastContentView.transform = .identity
            
        }
        
        switch self.toast.duration {
        case .seconds(let duration):
            
            self.dismissTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
                
                if let completion = completion {
                    completion()
                }
                self?.hide()
                
                self?.dismissTimer?.invalidate()
                self?.dismissTimer = nil
                
            }
            
        case .untilDismissed:
            
            if let completion = completion {
                completion()
            }
            
        }
        
    }
    
    func hide(completion: (()->())? = nil) {
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.1,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 1.0,
            options: .curveEaseIn) {
            
            let transform = (self.toastTopOffset + self.toastContentView.bounds.height)
            let directionTransform = self.direction == .top ? -transform : transform
            let startingTransform = CGAffineTransform(translationX: 0, y: directionTransform)
            
            self.toastContentView.alpha = 0.5
            self.toastContentView.transform = startingTransform
            
        } completion: { (bool) in
           
            if let completion = completion {
                completion()
            }
            
            self.removeFromSuperview()
        }
        
    }
    
}

