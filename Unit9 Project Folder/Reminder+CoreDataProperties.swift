//
//  Reminder+CoreDataProperties.swift
//  Unit9 Project Folder
//
//  Created by Joseph Heydorn on 1/9/20.
//  Copyright © 2020 Joseph Heydorn. All rights reserved.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var reminderText: String
    @NSManaged public var date: String
    @NSManaged public var locationLat: Double
    @NSManaged public var locationLon: Double
    @NSManaged public var onEntry: Bool

}
