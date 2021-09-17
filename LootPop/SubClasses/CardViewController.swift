//
//  CardViewController.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 7/7/21.
//

import RxSwift
import RxCocoa

class CardView: UIView {
    
    private(set) weak var cardViewController: CardViewController?
    
    func setup(in viewController: CardViewController) {
        self.cardViewController = viewController
    }
    
}

class CardViewController: UIViewController {
    
    private var backgroundContentView: UIView!
    private var backgroundDimmingView: UIView!
    
    private var contentView: UIView!
    private let cardView: UIView

    var statusBarStyle: UIStatusBarStyle = .default
    var backgroundDimmingAlpha: CGFloat = 0.4
    var isBackgroundTapToDismissEnabled: Bool = true
    
    private var isCardBeingDismissed: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    init(view: UIView) {
        
        self.cardView = view
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        self.view.backgroundColor = .clear
        self.view.isHidden = false // Force viewDidLoad
        self.modalPresentationStyle = .overFullScreen
        self.modalPresentationCapturesStatusBarAppearance = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupSubviews()
        
        if self.isBackgroundTapToDismissEnabled {

            self.view.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissCard))
            tap.numberOfTapsRequired = 1
            tap.delegate = self
            self.view.addGestureRecognizer(tap)

        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)

        UIView.animate(withDuration: 0.3) {
            self.setNeedsStatusBarAppearanceUpdate()
        }

    }
    
    private func setupSubviews() {
        
        setupBackgroundViews()
        
        self.contentView = UIView()
        self.contentView.backgroundColor = .clear
        self.contentView.clipsToBounds = true
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
        }
        
        self.contentView.addSubview(self.cardView)
        self.cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func setupBackgroundViews() {
                
        self.backgroundContentView = UIView()
        self.backgroundContentView.backgroundColor = .clear // .black
        self.view.addSubview(self.backgroundContentView)
        self.backgroundContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.backgroundDimmingView = UIView()
        self.backgroundDimmingView.backgroundColor = UIColor.black.withAlphaComponent(self.backgroundDimmingAlpha)
        self.backgroundDimmingView.alpha = 0
        self.backgroundContentView.addSubview(self.backgroundDimmingView)
        self.backgroundDimmingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    // MARK: Public
    
    func presentCard(from viewController: UIViewController,
                     completion: (()->())? = nil) {
        
        self.cardView.layoutSubviews()
        self.view.layoutIfNeeded()
        
        self.contentView.transform = CGAffineTransform(
            translationX: 0,
            y: self.contentView.bounds.height
        )
        
        viewController.present(
            self,
            animated: false,
            completion: nil
        )
        
        if self.isBackgroundTapToDismissEnabled {

            self.backgroundDimmingView.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissCard))
            tap.numberOfTapsRequired = 1
            tap.delegate = self
            self.backgroundDimmingView.addGestureRecognizer(tap)

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.backgroundDimmingView.alpha = 1
                self.contentView.transform = .identity
                
            }, completion: { isComplete in
                
                guard isComplete else { return }
                completion?()
                
            })
            
        }
        
    }
    
     @objc func dismissCard() {

        self.isCardBeingDismissed = true
                
        DispatchQueue.main.async {

            UIView.animate(withDuration: 0.3, animations: {
                
                self.backgroundDimmingView.alpha = 0
                
                self.contentView.transform = CGAffineTransform(
                    translationX: 0,
                    y: self.contentView.bounds.height
                )
                
                self.setNeedsStatusBarAppearanceUpdate()
                
            }, completion: { isComplete in
                self.dismiss(animated: false, completion: nil)
            })
            
        }
        
    }
    
}

extension CardViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.backgroundDimmingView
    }
    
}
