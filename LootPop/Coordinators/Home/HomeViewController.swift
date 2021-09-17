//
//  ViewController.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 4/24/21.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel!
    private var disposeBag: DisposeBag!
    
    init(viewModel: HomeViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupBinding()

    }
    
    private func setupSubviews() {
        
        // View
        
        self.view.simpleGradient(
            colors: [
                LPColor.lightPurple.color,
                LPColor.lightBlue.color
            ],
            direction: .topToBottom
        )
        
    }
    
    private func setupBinding() {
        
        self.disposeBag = DisposeBag()
        
    }
    
}

