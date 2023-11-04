//
//  HelperMethods.swift
//  HelperMethods
//
//  Created by Nawaf Almutairi on 7/21/21.
//

import SwiftUI
import Combine



extension Date {
    public var removeTimeStamp : Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            return nil
        }
        return date
    }
}

func stringArrayToData(stringArray: [String]) -> Data? {
    return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
}

func dataToStringArray(data: Data) -> [String]? {
    return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String]
}

public func Localized(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}



extension Date {
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: self)
    }
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: self)
    }
    
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
