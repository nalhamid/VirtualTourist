//
//  ViewController.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 17/12/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit
import MapKit
import CoreData


class ViewController: UIViewController {
    // Mark: outlets
    @IBOutlet weak var mapView: MKMapView!
    // activity Indicator
    let activityIndicator = UIActivityIndicatorView()
    //view model connect
    var pinViewModel = PinsViewModel()
    var photosViewModel = PhotosViewModel()
    // fetchedResultsController
    var mapFetchedResultsController : NSFetchedResultsController<Pin>!
    
    // Mark: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //set Activity Indicator
        setActivityIndicator(activityIndicator: activityIndicator)
        
        // add gesture Recognizer
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        view.addGestureRecognizer(recognizer)
    }

    // Mark: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //get pins
        setMapFetchedResultsController()
    }
}

