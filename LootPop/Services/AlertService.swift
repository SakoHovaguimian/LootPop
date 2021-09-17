//
//  AlertService.swift
//  Eidolon
//
//  Created by Sako Hovaguimian on 7/19/21.
//

import UIKit

protocol AlertServiceProtocol: AnyObject {
    
    // Aliases
    
    typealias Action = (()->())?
    
    // Alerts
    
    func showSimpleAlert()
    func showAlert(_ alert: UIAlertController)
    func showAlert(_ alert: UIAlertController, completion: Action)
    
    // Toast
    
    func showToast(_ toast: Toast)
    func showErrorToast(message: String)
    
    // Views
    
    func showView()
    func showView(_ view: UIView)
    
    // ViewControllers
    
    func present(_ vc: UIViewController)
    func presentZoomImageView(with image: UIImage)
    
}

class AlertService: AlertServiceProtocol {
    
    var currentModalViewController: UIViewController?
    
    var currentWindow: UIViewController {
        return (UIApplication.shared.windows.last?.rootViewController)!
    }
    
    func showToast(_ toast: Toast) {
        
        let toastView = ToastView(toast: toast, direction: .top)
        toastView.show(from: currentWindow.view)
        
    }
    
    func showErrorToast(message: String) {
        
        let toast = Toast(
            title: "Error",
            message: message) {
            print("Tapped it and now it's doing this")
        }
        
        let toastView = ToastView(toast: toast)
        toastView.show(from: currentWindow.view)
        
    }
    
    func showView() {
        //Do Something
    }
    
    func showView(_ view: UIView) {

        let vc = CardViewController(view: view)
        vc.presentCard(from: self.currentWindow)
        
    }
    
    func showSimpleAlert() {
        
        let alert = UIAlertController(title: "Alert", message: "There is an error!", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil) // Can pass action here
        alert.addAction(okayAction)
        
        present(alert)
        
    }
    
    func showAlert(_ alert: UIAlertController) {
        present(alert)
    }
    
    func showAlert(_ alert: UIAlertController, completion: Action) {
        
        if let closure = completion {
            closure()
        }
        
    }
    
    func present(_ vc: UIViewController) {
        self.currentWindow.present(vc, animated: true, completion: nil)
    }
    
    func presentZoomImageView(with image: UIImage) {
        
        let vc = PanGestureViewController()
            .setup(image: image)
        
        present(vc)
        
    }
    
}
