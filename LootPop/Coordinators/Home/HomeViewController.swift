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
    
    private var submitButton: UIButton!
    
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
        
        // SubmitButton
        
        self.submitButton = UIButton(type: .system)
        self.submitButton.backgroundColor = .clear
        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.setTitleColor(.white, for: .normal)
        self.submitButton.layer.cornerRadius = 23
        self.submitButton.clipsToBounds = true
        self.submitButton.addTapGesture { action in
            self.viewModel.handleButtonTap()
        }
        self.view.addSubview(self.submitButton)
        self.submitButton.snp.makeConstraints { make in
            make.left.equalTo(Spacing.xLarge.value)
            make.right.equalTo(-Spacing.xLarge.value)
            make.bottom.equalTo(-Spacing.xLarge.value)
            make.height.equalTo(50)
        }
        
    }
    
    private func setupBinding() {
        
        self.disposeBag = DisposeBag()
        
        self.viewModel.buttonText
            .bind { self.submitButton.setTitle($0, for: .normal)}
            .disposed(by: self.disposeBag)
        
    }
    
}

