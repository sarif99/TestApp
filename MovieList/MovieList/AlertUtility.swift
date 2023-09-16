//
//  AlertUtility.swift
//  MovieList
//
//  Created by Shehroz Arif on 16/09/2023.
//

import Foundation
import UIKit

class AlertUtility {
    
    static func showAlert(title: String, message: String, viewController: UIViewController) {
        // Ensure that UI updates are done on the main thread
        if Thread.isMainThread {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            viewController.present(alert, animated: true, completion: nil)
        } else {
            // If called from a background thread, dispatch to the main thread
            DispatchQueue.main.async {
                showAlert(title: title, message: message, viewController: viewController)
            }
        }
    }
}
