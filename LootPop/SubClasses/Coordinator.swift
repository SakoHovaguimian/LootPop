//
//  Coordinator.swift
//  DependencyExpectancy
//
//  Created by Sako Hovaguimian on 9/21/19.
//  Copyright © 2019 Sako Hovaguimian. All rights reserved.
//

import UIKit
import Swinject

struct AssociatedKeys {
    static var resolver: UInt8 = 0
}

protocol Coordinator {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
    
}

extension Coordinator /* DI */ {
    
    var resolver: Resolver? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.resolver) as? Resolver
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.resolver, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var currentNavController: UINavigationController { // was a func and i changed to lose the ()
        return self.childCoordinators.last?.navigationController ?? self.navigationController
    }
    
}
