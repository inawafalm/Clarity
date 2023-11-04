//
//  ClarityApp.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 10/2/20.
//

import SwiftUI


@main
struct ClarityApp: App {
    
    var settings = UserSettings2()


    //var postsModel = PostsModel()
    let persistenceController = CoreDataManager.shared
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
                //.environment(\.locale, .init(identifier: identifier))
                //.environment(\.layoutDirection, .rightToLeft)

        }
    }
}


enum Language: String {
    case english_us = "en"
    case arabic = "ar"
}


class UserSettings2: ObservableObject {

    @Published var lang: String = "en"

    var bundle: Bundle? {
        let b = Bundle.main.path(forResource: lang, ofType: "lproj")!
        return Bundle(path: b)
    }
}
