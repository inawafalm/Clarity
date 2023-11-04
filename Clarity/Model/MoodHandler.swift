//
//  MoodHandler.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 02/12/2021.
//

import Foundation




struct moodHandler: Codable {
    
    var currentMood: [String] = []
    var currentActivity: [String] = []
    var peopleWith: [String] = []
    var currentPlace: [String] = []
    let whatHappenText: String
    
    init(currentMood: [String],
         currentActivity:[String],
         peopleWith:[String],
         currentPlace:[String],
         whatHappenText:String) {
        self.currentMood = currentMood
        self.currentActivity = currentActivity
        self.peopleWith = peopleWith
        self.currentPlace = currentPlace
        self.whatHappenText = whatHappenText
    }
}

