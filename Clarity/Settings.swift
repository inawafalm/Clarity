//
//  SwiftUIView.swift
//  life
//
//  Created by Nawaf Almutairi on 6/29/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI

//TODO
// Number of times you have chacked your mood
// Stat for your mood.

struct SettingStruct : Identifiable {
    
    var id: Int
    var title : String
    var image: String
    
}

var SettingsData = [
    SettingStruct(id: 1, title: "Backup to iCloud", image: "square.and.arrow.down"),
    SettingStruct(id: 2, title: "Notification", image: "bell"),
    SettingStruct(id: 3, title: "Privacy & Security", image: "eye"),
    SettingStruct(id: 4, title: "About", image: "questionmark.circle")
]


struct Profile: View {
    
    
    @State var settingsArray = ["Backup to iCloud","Notification","Privacy & Security","Contact Us and Support","About"]
    
    var body: some View {
        
        NavigationView {
            NavigationLink(destination: Text("Hi")){
                
                List (SettingsData) { item in
                    HStack {
                        
                        Image(systemName: item.image)
                            .frame(width: 25, height: 25)
                        Text(item.title)
                            
                            .foregroundColor(.black)
                    }
                }
                .navigationBarTitle("Settings")
            }
        }
        .listStyle(PlainListStyle())
        
        /*
         VStack {
         Image("Nawaf")
         .resizable()
         .frame(width: 150, height: 150)
         .clipShape(Circle())
         .padding()
         
         Text("Nawaf Almutairi")
         .fontWeight(.light)
         
         Button(action: {
         
         }) {
         Text("Edit Profile")
         .foregroundColor(.white)
         .buttonStyle(DbuttonChoiceStyle())
         .padding()
         }
         Divider()
         
         Picker(selection: $pickerSelectedItem, label: Text("")){
         Text("1").tag(0)
         Text("2").tag(1)
         Text("3").tag(2)
         
         }.pickerStyle(SegmentedPickerStyle())
         .padding(.horizontal,24)
         
         HStack(spacing: 30){
         BarChart()
         BarChart()
         BarChart()
         BarChart()
         BarChart()
         }.padding(.top,24)
         
         Spacer()
         }
         */
        
    }
}

struct Profilee_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
        //DashboardGrid()
    }
}



/*
struct DashboardGrid: View {
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    var body: some View{
        
        LazyVGrid(columns: columns ,spacing: 30 ){
            
            ForEach(DashboardData) {dataa in
                
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text(dataa.title)
                            .foregroundColor(Color.white)
                        
                        Text("Hii")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top,10)
                        
                        HStack{
                            Spacer(minLength: 0)
                            Text("Hi3")
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(Color("Myblue"))
                    .cornerRadius(20)
                    // Shadow
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    
                    Image(systemName: "person")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.12))
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal)
        .padding(.top,25)
        
    }
    
}

*/
struct BarChart: View {
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule().frame(width:30,height:200)
                    .foregroundColor(Color("Mywhite"))
                Capsule().frame(width:30,height:100)
                    .foregroundColor(Color("Myblue"))
            }
            Text("D").padding(.top,8)
        }
    }
}
