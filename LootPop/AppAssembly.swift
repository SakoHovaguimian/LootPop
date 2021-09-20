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
                apiService: resolver.resolve(APIServiceProtocol.self)!,
                alertService: resolver.resolve(AlertServiceProtocol.self)!,
                firebaseService: resolver.resolve(FirebaseServiceProtocol.self)!
            )
        }.inObjectScope(.container)
        
    }
    
}

class ServiceRegistrationAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // Logger
        
        container.register(LoggerServiceProtocol.self) { resolver in 
            return LoggerService()
        }.inObjectScope(.container)
        
        // API
        
        container.register(APIServiceProtocol.self) { resolver in
            return APIService(
                loggerService: resolver.resolve(LoggerServiceProtocol.self)!
            )
        }.inObjectScope(.container)
        
        // UserDefaults
        
        container.register(UserDefaultsServiceProtocol.self) { resolver in
            return UserDefaultsService(
                loggerService: resolver.resolve(LoggerServiceProtocol.self)!
            )
        }.inObjectScope(.container)
        
        // Alert
        
        container.register(AlertServiceProtocol.self) { resolver in
            return AlertService(
                loggerService: resolver.resolve(LoggerServiceProtocol.self)!
            )
        }.inObjectScope(.container)
        
        // Firebase
        
        container.register(FirebaseServiceProtocol.self) { resolver in
            return FirebaseService(
                loggerService: resolver.resolve(LoggerServiceProtocol.self)!
            )
        }.inObjectScope(.container)
        
    }
    
}
