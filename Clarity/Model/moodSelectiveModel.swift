//
//  moodSelectiveModel.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 02/12/2021.
//

import Foundation


struct Selectable: Hashable {
    var item: String
    var isSelected: Bool = false
}


struct MoodSelective: Identifiable,Hashable,Decodable,Encodable {
    
    var id = UUID()
    var name : String
    
}

