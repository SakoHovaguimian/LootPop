//
//  PanGestureImageViewController.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 8/10/21.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class PanGestureViewController: UIViewController {
    
    private var image: UIImage!
    
    private var panZoomImageView: PanZoomImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
    }
    
    public func setup(image: UIImage) -> Self {
        
        self.image = image
        return self
        
    }
    
    private func setupSubviews() {
        
        self.panZoomImageView = PanZoomImageView(image: self.image)
        self.view.addSubview(self.panZoomImageView)
        self.panZoomImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

}
