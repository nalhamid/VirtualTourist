//
//  showAlert.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 22/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import UIKit
extension UIViewController{
    // show alert message
    func showAlert(title: String, message: String){
        let controller = UIAlertController()
        //set alert message
        controller.title = title
        controller.message = message
        //setButton
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default){ action in
            // self.dismiss(animated: true, completion: nil)
        }
        controller.addAction(okAction)
        // show message
        present(controller, animated: true, completion: nil)
    }
}
