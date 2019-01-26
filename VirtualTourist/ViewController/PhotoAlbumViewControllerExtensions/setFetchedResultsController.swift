//
//  setFetchedResultsController.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 20/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import UIKit
import CoreData

extension PhotoAlbumViewController : NSFetchedResultsControllerDelegate{
    // Mark: setFetchedResultsController
    func setFetchedResultsController(){
        DataController.shared.viewContext.perform {
            //link collection view with image entity by selected pin
            let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.predicate = NSPredicate(format: "pin == %@", self.pin)
            self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataController.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            self.fetchedResultsController.delegate = self
            do {
                try self.fetchedResultsController.performFetch()
            } catch let error{
                print(error)
            }
            DispatchQueue.main.async {
                // reload collection after updates
                self.collectionView.reloadData()
            }
        }
        
    }
    
    // Mark: didChange Object
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        // reflect from coredata updates on collection view
        switch type {
        case .insert:
            blockOperations.append(BlockOperation(block: {
                self.collectionView.insertItems(at: [newIndexPath!])
            }))
            break
        case .delete:
            blockOperations.append(BlockOperation(block: {
                self.collectionView.deleteItems(at: [indexPath!])
            }))
            break
        case .move:
            blockOperations.append(BlockOperation(block: {
                self.collectionView.moveItem(at: indexPath!, to: newIndexPath!)
            }))
            break
        case .update:
            blockOperations.append(BlockOperation(block: {
                self.collectionView.reloadItems(at: [indexPath!])
            }))
            break
        }
    }
    
    // Mark: controllerDidChangeContent
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
   //     DispatchQueue.main.async {
            // loop updates
            self.collectionView.performBatchUpdates({
                for operation in self.blockOperations {
                    operation.start()
                }
            }, completion:{ (finished) -> Void in
                self.blockOperations.removeAll(keepingCapacity: false)
            })
      //  }
        // reload collection after updates
        //  collectionView.reloadData()
    }
    
}
