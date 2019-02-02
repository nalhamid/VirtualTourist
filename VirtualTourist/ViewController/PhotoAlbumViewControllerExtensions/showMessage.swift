//
//  showMessage.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 23/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//  source: https://stackoverflow.com/questions/43772984/how-to-show-a-message-when-collection-view-is-empty

import UIKit

extension PhotoAlbumViewController {
    // Mark: showMessage
    func showMessage(_ message: String) {
        //set Activity Indicator
        activityIndicator.startAnimating()
        // set message if there is no photos to view
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Avenir-Light", size: 18)
        messageLabel.sizeToFit()
        // set message to background
        collectionView.backgroundView = messageLabel;
    }
    // Mark: restoreCollectionview
    func restoreCollectionview() {
        //stop Activity Indicator
        activityIndicator.stopAnimating()
        collectionView.backgroundView = nil
    }
}
