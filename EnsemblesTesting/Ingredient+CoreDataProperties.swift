//
//  Ingredient+CoreDataProperties.swift
//  EnsemblesTesting
//
//  Created by Bliss Chapman on 7/17/16.
//  Copyright © 2016 Bliss Chapman. All rights reserved.
//

import Foundation
import CoreData

extension Ingredient {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient");
    }

    @NSManaged var amount: Double
    @NSManaged var name: String?
    @NSManaged var recipe: Recipe?

}
