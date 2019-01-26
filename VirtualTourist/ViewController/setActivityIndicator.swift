//
//  setActivityIndicator.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 22/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import UIKit

extension UIViewController {
    // Mark: setActivityIndicator
    func setActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        activityIndicator.center = self.view.center
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
}
