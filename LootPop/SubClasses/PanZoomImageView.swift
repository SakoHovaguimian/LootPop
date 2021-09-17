//
//  PanZoomImageView.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 8/10/21.
//

import UIKit

class PanZoomImageView: UIScrollView {

    private(set) var imageView = UIImageView()

    init(image: UIImage) {
        
        super.init(frame: .zero)
        self.imageView.image = image
        
        setupSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        
        self.minimumZoomScale = 1
        self.maximumZoomScale = 3
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.delegate = self
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.clipsToBounds = true
        addSubview(self.imageView)

        NSLayoutConstraint.activate([
            
            self.imageView.widthAnchor.constraint(equalTo: widthAnchor),
            self.imageView.heightAnchor.constraint(equalTo: heightAnchor),
            self.imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: centerYAnchor)

        ])
        
        let doubleTapRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleDoubleTap(_:))
        )
        doubleTapRecognizer.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapRecognizer)

    }
    
    @objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {

        if zoomScale == 1 {
            setZoomScale(2, animated: true)
        } else {
            setZoomScale(1, animated: true)
        }

    }
    
}

extension PanZoomImageView: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
}
