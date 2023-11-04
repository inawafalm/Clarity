//
//  new1.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 02/12/2021.
//

import Foundation


class EntriesSettings: ObservableObject {
    
    @Published var moodArray : [MoodSelective] = [
                                                  MoodSelective(name: NSLocalizedString("Wonderful", comment: "")),
                                                  MoodSelective(name: NSLocalizedString("Excited", comment: "")),
                                                  MoodSelective(name: NSLocalizedString("Happy", comment: "")),
                                                  MoodSelective(name: NSLocalizedString("Calm", comment: "")),
                                                  MoodSelective(name: NSLocalizedString("I don't know", comment: "")),
                                                  MoodSelective(name: NSLocalizedString("Streesed", comment: ""))
    ]
    {
        didSet {
            saveItems(entryArray: moodArray, forKey: "moodArray")
        }
    }
    
    @Published var activityArray : [MoodSelective] = [
        MoodSelective(name: NSLocalizedString("Working", comment: "")),
        MoodSelective(name: NSLocalizedString("Watching a movie", comment: "")),
        MoodSelective(name: NSLocalizedString("Drinking coffee", comment: "")),
        MoodSelective(name: NSLocalizedString("Nothing", comment: "")),
        MoodSelective(name: NSLocalizedString("Workout", comment: "")),
        MoodSelective(name: NSLocalizedString("Going out", comment: ""))
    ]
    {
        didSet {
            saveItems(entryArray: activityArray, forKey: "activityArray")
        }
    }
    
    @Published var peopleArray : [MoodSelective] = [
        
        MoodSelective(name: NSLocalizedString("Friends", comment: "")),
        MoodSelective(name: NSLocalizedString("Parents", comment: "")),
        MoodSelective(name: NSLocalizedString("Dog", comment: "")),
        MoodSelective(name: NSLocalizedString("Alone", comment: "")),
        MoodSelective(name: NSLocalizedString("Colleages", comment: "")),
        MoodSelective(name: NSLocalizedString("Spouse", comment: ""))
                                                    ]
    {
        didSet {
            saveItems(entryArray: peopleArray, forKey: "peopleArray")
        }
    }
    
    @Published var placeArray : [MoodSelective] = [
        MoodSelective(name: NSLocalizedString("Home", comment: "")),
        MoodSelective(name: NSLocalizedString("Work", comment: "")),
        MoodSelective(name: NSLocalizedString("Coffee Shop", comment: "")),
        MoodSelective(name: NSLocalizedString("Park", comment: "")),
        MoodSelective(name: NSLocalizedString("School", comment: ""))]
        {
        didSet {
            saveItems(entryArray: placeArray, forKey: "placeArray")
        }
    }
    
    
    
    
    init () {
       
        guard
            let data = UserDefaults.standard.data(forKey: "moodArray"),
            let savedItems = try? JSONDecoder().decode([MoodSelective].self, from: data)
        else { return }
        self.moodArray = savedItems
        
        guard
            let data2 = UserDefaults.standard.data(forKey: "activityArray"),
            let savedItems2 = try? JSONDecoder().decode([MoodSelective].self, from: data2)
        else { return }
         self.activityArray = savedItems2
        
        guard
            let data3 = UserDefaults.standard.data(forKey: "peopleArray"),
            let savedItems3 = try? JSONDecoder().decode([MoodSelective].self, from: data3)
        else { return }
         self.peopleArray = savedItems3
        
        guard
            let data4 = UserDefaults.standard.data(forKey: "placeArray"),
            let savedItems4 = try? JSONDecoder().decode([MoodSelective].self, from: data4)
        else { return }
         self.placeArray = savedItems4
        
    }
    
    
    func deleteMood(at offsets: IndexSet) {
        moodArray.remove(atOffsets: offsets)
    }
    
    func deleteActivity(at offsets: IndexSet) {
        activityArray.remove(atOffsets: offsets)
    }
    
    func deletePeople(at offsets: IndexSet) {
        peopleArray.remove(atOffsets: offsets)
    }
    
    func deletePlace(at offsets: IndexSet) {
        placeArray.remove(atOffsets: offsets)
    }
    
    
    func saveItems(entryArray: [MoodSelective],forKey:String) {
        if let encodedData = try? JSONEncoder().encode(entryArray) {
            UserDefaults.standard.set(encodedData, forKey: forKey
            )
        }
    }
    
}
