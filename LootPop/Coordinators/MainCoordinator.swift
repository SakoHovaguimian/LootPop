//
//  MainCoordinator.swift
//  Lyst.
//
//  Created by Sako Hovaguimian on 4/14/20.
//  Copyright © 2020 Sako Hovaguimian. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        self.childCoordinators = [Coordinator]()
        
    }
    
    func start() {
        
        self.navigationController.modalPresentationStyle = .fullScreen
        self.navigationController.navigationBar.isHidden = true
        
        let nc = UINavigationController()
        
        var homeCoord = HomeCoordinator(
            delegate: self,
            navigationController: nc
        )
        homeCoord.resolver = self.resolver
        homeCoord.start()
        
        self.navigationController.present(
            nc,
            animated: false,
            completion: nil
        )
        
        self.childCoordinators.append(homeCoord)
        
    }
    
}

    
    //MARK:- Alawys Append and Remove Coordinator from child...
    //MARK:- self.currentNavController is used to append, dismiss, remove from nav stack
