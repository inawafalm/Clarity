//
//  AppView.swift
//  life
//
//  Created by Nawaf Almutairi on 2/2/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI

// TODO
// New icons for tabbar.
// Use the library




struct AppView: View {
    var body: some View {
            TabBarView()        
    }
}




struct TabBarView : View {
    
    @State var tab1 = "house.circle"
    @State var tab2 = "calendar.circle"
    @State var tab3 = "gearshape"
    @State private var selection = 0

    
    init() {
        setupTabBar()
        
        if #available(iOS 15.0, *) {
        UITabBar.appearance().backgroundColor = UIColor(named: "Myblue")
        }
    }
    
    var body: some View{
        
        
        TabView(selection: $selection) {
            MyMoodList().tabItem
            {
                    Image(systemName: tab1)
                    Text("Home")
                
            }.tag(0)


            Profile()
                .tabItem {
                    Image(systemName: tab3)
                        Text("Settings")
                }
                .tag(2)

            
        }.accentColor(.white)
        
        
    }
}

//MARK: - Tab bar view appearance
extension TabBarView {
  func setupTabBar() {
    UITabBar.appearance().barTintColor = UIColor(named: "Myblue")
    UITabBar.appearance().tintColor = .white
    UITabBar.appearance().unselectedItemTintColor =  UIColor(.white.opacity(0.5))
   
  }
}



struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 pro"))
                .previewDisplayName("iPhone 12 pro")

            AppView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
                .previewDisplayName("iPhone 12 mini")

            AppView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
                .previewDisplayName("iPhone 8")
            
        }
    }
}



