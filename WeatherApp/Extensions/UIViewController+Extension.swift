//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by Bruno Frani on 6.3.22.
//

import UIKit


extension UIViewController {
  
  private var overlayContainerView: UIView {
    if let navigationView: UIView = navigationController?.view {
      return navigationView
    }
    return view
  }
  
  func displayAnimatedActivityIndicatorView() {
    overlayContainerView.displayAnimatedActivityIndicatorView()
  }
  
  func hideAnimatedActivityIndicatorView() {
    overlayContainerView.hideAnimatedActivityIndicatorView()
  }
  
  func showAlert(alertText : String, alertMessage : String, buttonText: String) {
    let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)  }
}

