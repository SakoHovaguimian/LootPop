//
//  AppAssembly.swift
//  DependencyExpectancy
//
//  Created by Sako Hovaguimian on 9/21/19.
//  Copyright © 2019 Sako Hovaguimian. All rights reserved.
//

import Swinject

class ServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // HomeViewModel
        
        container.register(HomeViewModel.self) { resolver in
            return HomeViewModel(
                loggerService: resolver.resolve(LoggerServiceProtocol.self)!,
                alertService: resolver.resolve(AlertServiceProtocol.self)!
            )
        }.inObjectScope(.container)
        
    }
    
}

class ServiceRegistrationAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // UserDefaults
        container.register(UserDefaultsServiceProtocol.self) { resolver in
            return UserDefaultsService()
        }.inObjectScope(.container)
        
        // Logger
        
        container.register(LoggerServiceProtocol.self) { resolver in
            return LoggerService()
        }.inObjectScope(.container)
        
        // Alert
        
        container.register(AlertServiceProtocol.self) { resolver in
            return AlertService()
        }.inObjectScope(.container)
        
    }
    
}
