//
//  HomeViewModel.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 4/24/21.
//

import UIKit
import RxSwift
import RxCocoa
import PromiseKit
import Alamofire

protocol HomeViewModelDelegate: AnyObject {

}

class HomeViewModel {

    private let loggerService: LoggerServiceProtocol!
    private let alertService: AlertServiceProtocol!
    
    private var _buttonText = BehaviorRelay<String>(value: "Submit")
    var buttonText: Observable<String> {
        return self._buttonText.asObservable()
    }
    
    private weak var delegate: HomeViewModelDelegate!
    
    init(loggerService: LoggerServiceProtocol,
         alertService: AlertServiceProtocol) {
        
        self.alertService = alertService
        self.loggerService = loggerService
        
    }
    
    public func setup(delegate: HomeViewModelDelegate) -> Self {
        
        self.delegate = delegate
        return self
        
    }
    
    public func handleButtonTap() {
        self._buttonText.accept("Tapped Nice")
    }
    
}
