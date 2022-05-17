//
//  Audio+CoreDataProperties.swift
//  
//
//  Created by Apple on 14/12/2021.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Audio {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Audio> {
        return NSFetchRequest<Audio>(entityName: "Audio")
    }

    @NSManaged public var audioPath: String?
    @NSManaged public var diagnosis: String?
    @NSManaged public var location: String?
    @NSManaged public var patient: String?
    @NSManaged public var position: String?
    @NSManaged public var student: Student?

}
