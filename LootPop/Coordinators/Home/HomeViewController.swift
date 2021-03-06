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
    private var cardImageView: UIImageView!
    private var cardView: UIView!
    
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
    
    override func viewWillLayoutSubviews() {

        super.viewWillLayoutSubviews()
        
        self.submitButton.layer.cornerRadius = 23
        self.submitButton.simpleGradient(
            colors: [
                .brandPurple,
                .brandBlue
            ]
            ,
            direction: .topToBottom
        )
        self.submitButton.layer.cornerRadius = 23
        
    }
    
    private func setupSubviews() {
        
        // View
        
//        self.view.simpleGradient(
//            colors: [
//                LPColor.lightPurple.color,
//                LPColor.lightBlue.color
//            ],
//            direction: .topToBottom
//        )
        
        self.view.backgroundColor = LPColor.backgroundGray.color
        
        // BlurView
        
        self.view.addBlurView()
        
        // SubmitButton
        
        self.submitButton = UIButton(type: .system)
        self.submitButton.setTitle("Submit", for: .normal)
        self.submitButton.setTitleColor(LPColor.brandWhite.color, for: .normal)
        self.submitButton.layer.cornerRadius = 23
        self.submitButton.clipsToBounds = true
        self.submitButton.addTapGesture { action in
            self.viewModel.handleButtonTap()
            self.cardImageView.layer.removeAllAnimations()
        }
        self.view.addSubview(self.submitButton)
        self.submitButton.snp.makeConstraints { make in
            make.left.equalTo(Spacing.xLarge.value)
            make.right.equalTo(-Spacing.xLarge.value)
            make.bottom.equalTo(-Spacing.xLarge.value)
            make.height.equalTo(50)
        }
        self.submitButton.addShadow()
        
        // CardImageView
        
        self.cardImageView = UIImageView(image: UIImage(systemName: "greetingcard"))
        self.cardImageView.backgroundColor = LPColor.brandPink.color
        self.cardImageView.isUserInteractionEnabled = true
        self.cardImageView.layer.cornerRadius = 34
        self.cardImageView.addTapGesture { _ in
            
            let image = UIImage(systemName: "greetingcard.fill")
            self.cardImageView.image = image
            
            UIView.animate(withDuration: 0.01) {
                
                self.viewModel.animateCardView(self.cardImageView)
                
            } completion: { completion in
                
                UIView.transition(
                    with: self.cardImageView,
                    duration: 1.0,
                    options: .transitionFlipFromLeft,
                    animations: nil,
                    completion: { _ in
                        print("Done")
                    }
                )
                
            }
            
        }
        self.view.addSubview(self.cardImageView)
        self.cardImageView.snp.makeConstraints { make in
            make.top.equalTo(Spacing.xLarge.value)
            make.left.equalTo(Spacing.xLarge.value)
            make.right.equalTo(-Spacing.xLarge.value)
            make.height.equalTo(Spacing.custom(300).value)
        }
        
        // CardView
        
        self.cardView = UIView()
        self.cardView.layer.cornerRadius = Spacing.medium.value
        self.cardView.backgroundColor = .white
        self.view.addSubview(self.cardView)
        self.cardView.snp.makeConstraints { make in
            make.top.equalTo(self.cardImageView.snp.bottom).offset(Spacing.xLarge.value)
            make.left.equalTo(Spacing.xLarge.value)
            make.right.equalTo(-Spacing.xLarge.value)
            make.height.equalTo(100)
        }
        self.cardView.addShadow(
            opacity: 0.1,
            offset: CGSize(width: 0, height: 0),
            radius: 4
        )
        
        self.cardView.addTapGesture { _ in
            
            let updatedColor = self.cardView.backgroundColor == LPColor.brandPurple.color
            ? .white
            : LPColor.brandPurple.color
            
            self.cardView.backgroundColor = updatedColor
            
        }
        
    }
    
    private func setupBinding() {
        
        self.disposeBag = DisposeBag()
        
        self.viewModel.buttonText
            .bind { self.submitButton.setTitle($0, for: .normal)}
            .disposed(by: self.disposeBag)
        
    }
    
}

