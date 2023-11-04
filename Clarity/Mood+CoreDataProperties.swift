//
//  Mood+CoreDataProperties.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 6/21/21.
//
//

import Foundation
import CoreData


extension Mood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mood> {
        return NSFetchRequest<Mood>(entityName: "Mood")
    }

    @NSManaged public var currentMood: Data?
    @NSManaged public var currentActivity: Data?
    @NSManaged public var id: UUID?
    @NSManaged public var peopleWith: Data?
    @NSManaged public var currentPlace: Data?
    @NSManaged public var journaling: String?
    @NSManaged public var currentMoment: String?
    @NSManaged public var decodedDate: Date? 
    @NSManaged public var selectedDate: String?
    @NSManaged public var time: String?
    @NSManaged public var year: String?
    @NSManaged public var month: String?
    @NSManaged public var day: String?

}

extension Mood : Identifiable {

}
