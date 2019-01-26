//
//  collectionDelegate.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 21/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import UIKit
import Kingfisher

extension PhotoAlbumViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    // Mark: number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numOfItems = 0
        // fetchedResultsController
        guard let fetchedResultsController = self.fetchedResultsController else {
            //set Activity Indicator
            activityIndicator.startAnimating()
            showMessage("Loading...")
            return 0
        }
        // check section
        guard let sections = fetchedResultsController.sections else {
            activityIndicator.stopAnimating()
            showMessage("No Photos near this location")
            return 0
        }
        activityIndicator.stopAnimating()
        // return number of images or zero if nil
        numOfItems = sections[0].numberOfObjects

        if (numOfItems == 0){
            // set "no images" message
            showMessage("No Photos near this location")
        }else {
            // remove message
            restoreCollectionview()
        }
        return numOfItems
    }
    
    // Mark: cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageViewCell
       activityIndicator.startAnimating()
        // retrive image
        if let image = fetchedResultsController.object(at: indexPath).image {
            cell.image.image = UIImage(data:image)
        }else{
            cell.image.image = UIImage(named: "placeholder")
        }
        activityIndicator.stopAnimating()
        return cell
    }
    // set collection view features
    // Mark: shouldSelectItemAt
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    // Mark: shouldDeselectItemAt
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    // Mark: didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // set cell settings for selections
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.alpha = 0.6
        // change button label
        newCollections.setTitle("Delete Selected Images", for: .normal)
    }
    // Mark: didDeselectItemAt
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // reset cell 
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0
        cell?.layer.borderColor = nil
        cell?.alpha = 1
        // change button label
        if let selectedList = collectionView.indexPathsForSelectedItems, !selectedList.isEmpty {
            newCollections.setTitle("Delete Selected Images", for: .normal)
        } else {
            newCollections.setTitle("Get New Collection", for: .normal)
        }
    }
    
}
