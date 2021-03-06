//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 06/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import UIKit
import CoreData
import UIEmptyState

class PhotoAlbumViewController : UIViewController {
    
    // Mark: Outlets
    @IBOutlet weak var newCollections: UIButton!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // activity Indicator
    let activityIndicator = UIActivityIndicatorView()
    
    // Mark: Variables
    var pin : Pin!
    var fetchedResultsController : NSFetchedResultsController<Photo>!
    var blockOperations = [BlockOperation]()
    //view model connect
    var pinViewModel = PinsViewModel()
    var photosViewModel = PhotosViewModel()
    
    // Mark: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // set empty state
        setUIEmptyState()
        //Allow multiple collections
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
    }
    
    // Mark: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //set Activity Indicator
        setActivityIndicator(activityIndicator: activityIndicator)
        // set fetch results
        setFetchedResultsController()
        // set flow layout
        setFlowLayout()
    }
    
    // Mark: viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadEmptyStateForCollectionView(self.collectionView)
    }
    
    // Mark: getNewCollection
    @IBAction func getNewCollection(_ sender: Any) {
        // check if there selected photos
        if let selectedList = collectionView.indexPathsForSelectedItems, !selectedList.isEmpty {
            DataController.shared.viewContext.perform {
                //delete just selected photos
                for photoIndex in selectedList {
                    let photo = self.fetchedResultsController.object(at: photoIndex)
                    DataController.shared.viewContext.delete(photo)
                }
                do{
                    // save to context
                    try DataController.shared.viewContext.save()
                } catch (let error){
                    print(error)
                }
            }
        }else {
            // delete all objects under pin
            DataController.shared.viewContext.perform {
                if let photoList = self.fetchedResultsController.fetchedObjects{
                    for photo in photoList{
                        DataController.shared.viewContext.delete(photo)
                    }
                    do{
                        // save to context
                        try DataController.shared.viewContext.save()
                    } catch (let error){
                        print(error)
                    }
                    // get new images
                    DispatchQueue.main.async {
                        self.photosViewModel.getImages(pin: self.pin, completion: { (success, message) in
                            if(success){
                                print("got new images")
                            }
                        })
                    }
                }
            }
        }
    }
}
