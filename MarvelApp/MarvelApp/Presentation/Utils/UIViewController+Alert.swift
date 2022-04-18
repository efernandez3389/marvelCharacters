//
//  UIViewController+Alert.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 18/4/22.
//

import UIKit

extension UIViewController {
        
        func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: completion)
        }
}
