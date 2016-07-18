//
//  MyRecipesViewController.swift
//  EnsemblesTesting
//
//  Created by Bliss Chapman on 7/17/16.
//  Copyright © 2016 Bliss Chapman. All rights reserved.
//

import UIKit
import CoreData

final class MyRecipesViewController: CoreDataTableViewController<Recipe> {


    //MARK: Model
    var managedObjectContext: NSManagedObjectContext? = (UIApplication.shared().delegate as? AppDelegate)?.persistentContainer.viewContext {
        didSet {
            updateUI()
        }
    }

    private func updateUI() {
        if let context = managedObjectContext {

            let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
            request.sortDescriptors = [
                SortDescriptor(key: "title", ascending: true)
            ]
            request.predicate = nil

            fetchedResultsController = NSFetchedResultsController<Recipe>(
                fetchRequest:request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)

        } else {
            // setting the fetched results controller to nil will clear the table
            fetchedResultsController = nil
        }
    }


    //MARK: View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
