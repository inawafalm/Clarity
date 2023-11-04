//
//  thoughtModel.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 02/12/2021.
//

import Foundation


struct ThoughtStructure: Identifiable,Codable,Hashable {
    
    var id = UUID()
    var trigger : String
    var autoThought : String
    var emotions : String
    var EFT : String
    var EAT : String
    var alterThought : String
    var outcome : String
    var decodedDate: Date
    let selectedDate: String
    let time: String
    let year: String
    let month: String
    let day: String
    
}
