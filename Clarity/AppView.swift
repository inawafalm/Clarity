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
        NavigationView{
            TabBarView()
                .navigationTitle("")
                .navigationBarHidden(true)
        }
    }
}



var tabs = ["MoodTrack","MentalFeed","Profile",""]



struct TabBarView : View {
    
    @State var tab = "heart"
    
    var body: some View{
        
        VStack{
            
            switch(tab){

            case "heart":
                MyMoodList(currentMood: [""], currentActivity: [""], peopleWith: [""], currentPlace: [""], whatHappenText: "", currentMoment: "")
            case "list.bullet":
                testFeedView()

            case "pencil":
                MentalFeed()
                    .navigationTitle("MentalFeed")

            case "slider.horizontal.3" :
                Profile()

            default:
                Profile()


            }
            
            Spacer()
            
            HStack(spacing:6){

                TabButton2(title: "heart", tab: $tab)
                Spacer(minLength: 0)
                
                TabButton2(title: "list.bullet", tab: $tab)
                Spacer(minLength: 0)
                
                TabButton2(title: "pencil", tab: $tab)
                Spacer(minLength: 0)
                
                TabButton2(title: "slider.horizontal.3", tab: $tab)
                
                
            }
            .padding(.top)
            .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 :
                        UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .padding(.horizontal,35)
            //.padding(.bottom)
            .background(Color("Myblue"))
            
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}


struct TabButton2 : View {
    
    var title : String
    @Binding var tab : String
    
    var body: some View{
        
        Button(action: {tab = title}) {
            
            VStack(spacing: 5){
                Image(systemName: title)
                    .font(.headline)
                    .foregroundColor(tab == title ? Color("Myblue") : .white)
                
                     //Text(title)
                  //  .foregroundColor(tab == title ? Color("Myblue") : .white)
            
               //.fontWeight(.bold)
            }
            .padding(.vertical,10)
            .padding(.horizontal)
            .background(Color.white.opacity(tab == title ? 1 : 0))
            .clipShape(Capsule())
            .shadow(radius: 3)
            
            
        }
        
        
        
    }
    
}



struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}



