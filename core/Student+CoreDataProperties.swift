//
//  Student+CoreDataProperties.swift
//  core
//
//  Created by Yogesh Patel on 26/04/18.
//  Copyright © Haider Tamsil. All rights reserved.
//
//

import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student")
    }

    @NSManaged public var name: String?
    @NSManaged public var city: String?
    @NSManaged public var cnic: String?
    @NSManaged public var contact: String?
    @NSManaged public var age: String?
    @NSManaged public var drID: String?
    

}

