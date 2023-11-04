//
//  ThoughtRecord+CoreDataProperties.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 12/11/2021.
//
//

import Foundation
import CoreData


extension ThoughtRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ThoughtRecord> {
        return NSFetchRequest<ThoughtRecord>(entityName: "ThoughtRecord")
    }

    @NSManaged public var alterThought: String?
    @NSManaged public var autoThought: String?
    @NSManaged public var day: String?
    @NSManaged public var decodedDate: Date
    @NSManaged public var eat: String?
    @NSManaged public var eft: String?
    @NSManaged public var emotion: String?
    @NSManaged public var month: String?
    @NSManaged public var outcome: String?
    @NSManaged public var selectedDate: String?
    @NSManaged public var trigger: String?
    @NSManaged public var year: String?
    @NSManaged public var time: String?
    @NSManaged public var id: UUID?


}

extension ThoughtRecord : Identifiable {

}
