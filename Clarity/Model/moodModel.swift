//
//  Structures.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 02/12/2021.
//

import Foundation
import Combine


struct moodStructure: Identifiable,Codable,Hashable {
    
    var id = UUID()
    let currentMood: [String]
    let currentActivity: [String]
    let peopleWith: [String]
    let currentPlace: [String]
    let journaling: String
    let currentMoment: String
    var decodedDate: Date
    let selectedDate: String
    let time: String
    let year: String
    let month: String
    let day: String
}



