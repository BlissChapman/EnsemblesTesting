//
//  Recipe+CoreDataProperties.swift
//  EnsemblesTesting
//
//  Created by Bliss Chapman on 7/17/16.
//  Copyright © 2016 Bliss Chapman. All rights reserved.
//

import Foundation
import CoreData

extension Recipe {

    @nonobjc class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe");
    }

    @NSManaged var title: String?
    @NSManaged var ingredients: NSSet?

}
