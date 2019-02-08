//
//  setUIEmptyState.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 07/02/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//
import UIKit
import UIEmptyState

extension PhotoAlbumViewController:  UIEmptyStateDataSource, UIEmptyStateDelegate {
    // setUIEmptyState
    func setUIEmptyState(){
        self.emptyStateDelegate = self
        self.emptyStateDataSource = self
    }
    
    var emptyStateImage: UIImage? {
        return UIImage(named: "load")
    }
    
    // message
    var emptyStateTitle: NSAttributedString {
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor(red:0.00, green:0.70, blue:1.00, alpha: 1.00),
                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22)]
        return NSAttributedString(string: "Loading...", attributes: attrs)
    }

}
