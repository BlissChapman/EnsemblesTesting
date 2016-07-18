//
//  CoreDataTableViewController.swift
//  EnsemblesTesting
//
//  Created by William Chapman on 5/30/16.
//  Copyright © 2016 William Chapman. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTableViewController<T: NSFetchRequestResult>: UITableViewController {
    
    var fetchedResultsController: NSFetchedResultsController<T>? {
        didSet {
            do {
                if let frc = fetchedResultsController {
                    frc.delegate = self
                    try frc.performFetch()
                }
                tableView.reloadData()
            } catch let error {
                print("XX NSFetchedResultsController.performFetch failed: \(error)")
            }
        }
    }
    
    // MARK: TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController?.sections where sections.count > 0 {
            print("inside tableView numberOfRowsInSection: \(sections[section].numberOfObjects)")
            return sections[section].numberOfObjects
        } else {
            print("inside tableView numberOfRowsInSection: 0")
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController?.sections where sections.count > 0 {
            return sections[section].name
        } else {
            return nil
        }
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController?.sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return fetchedResultsController?.section(forSectionIndexTitle: title, at: index) ?? 0
    }
}

//MARK: NSFetchedResultsControllerDelegate
extension CoreDataTableViewController: NSFetchedResultsControllerDelegate {

    @nonobjc func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    @nonobjc func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert: tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete: tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default: break
        }
    }


    @nonobjc func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: AnyObject, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        //NOTE: indexPath is nil on an insertion and newIndexPath is nil on a deletion
        switch type {
        case .insert: tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete: tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update: tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }

    @nonobjc func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
