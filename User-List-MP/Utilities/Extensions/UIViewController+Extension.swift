//
//  UIViewController+Extension.swift
//  Users-Miho
//
//  Created by Mac on 9/10/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertDialog(_ title: String, _ message: String, buttonTitle: String = "OK") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
