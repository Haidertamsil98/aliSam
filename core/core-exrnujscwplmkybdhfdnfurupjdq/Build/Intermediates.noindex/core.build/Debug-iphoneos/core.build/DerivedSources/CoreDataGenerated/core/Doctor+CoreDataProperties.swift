//
//  Doctor+CoreDataProperties.swift
//  
//
//  Created by Apple on 14/12/2021.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Doctor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Doctor> {
        return NSFetchRequest<Doctor>(entityName: "Doctor")
    }

    @NSManaged public var id: String?
    @NSManaged public var student: Student?

}
