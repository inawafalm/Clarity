//
//  UserSettings.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 02/12/2021.
//

import Foundation


class UserSettings: ObservableObject {

    @Published var iCloud: Bool {
            didSet {
                UserDefaults.standard.set(iCloud, forKey: "iCloud")
            }
        }
    
//    @Published var languageSelected: String {
//            didSet {
//                UserDefaults.standard.set(iCloud, forKey: "language")
//            }
//        }
    
    
    
    init() {
        self.iCloud = UserDefaults.standard.object(forKey: "iCloud") as? Bool ?? false
        //self.languageSelected = UserDefaults.standard.object(forKey: "language") as! String
    }
    
}
