//
//  HomeCoordinator.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 4/24/21.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    
}

class HomeCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private weak var delegate: HomeCoordinatorDelegate!
    
    init(delegate: HomeCoordinatorDelegate,
         navigationController: UINavigationController) {
        
        self.delegate = delegate
        self.navigationController = navigationController
        
    }
    
    func start() {
        
        let viewModel = resolver!.resolve(HomeViewModel.self)!
            .setup(delegate: self)
        
        let homeVC = HomeViewController(viewModel: viewModel)
        
        self.navigationController.modalPresentationStyle = .fullScreen
        self.navigationController.navigationBar.isHidden = true
        self.navigationController.pushViewController(
            homeVC,
            animated: false
        )
        
    }
    
}

extension HomeCoordinator: HomeViewModelDelegate {
    
}
