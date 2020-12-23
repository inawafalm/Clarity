//
//  MoodDetail.swift
//  life
//
//  Created by Nawaf Almutairi on 4/27/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI

// TODO
// EVERYTHING.



struct MoodDetail: View {
    
    
    var moodDetail = moodStructure(currentMood: [""], currentActivity: [""], peopleWith: [""], currentPlace: [""], whatHappenText: "", currentMoment: "", selectedDate: "")
    
    @State var myText = ""
    @Binding var  isPresented: Bool
    @State private var AnimationShow = false
    @State private var toggle = false
    
    var columns: [GridItem] = [
        GridItem(.fixed(100), spacing: 16),
        GridItem(.fixed(100), spacing: 16),
        GridItem(.fixed(100), spacing: 16)
    ]
    
    @State var textPassed = ""
    
    var body: some View {
        
        VStack {
            
            MoodCard(moodDetail: moodDetail, currentMoment: "",currentMood: ["String","2"] ,isPresented: $isPresented, AnimationShow: AnimationShow)
                .opacity(AnimationShow ? 1 : 0)
                .onAppear {
                    withAnimation(Animation.easeIn(duration: 0.6).delay(0.4)) {
                        self.AnimationShow.toggle()
                        print(moodDetail)
                    }
                }
            
            
            // Journaling
            Text("Hi")
                .multilineTextAlignment(.leading)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity,
                       minHeight: 0, maxHeight: 400,alignment: .topLeading)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()
                .opacity(AnimationShow ? 1 : 0)
                .offset(y: AnimationShow ? 0 : 20)
                .onAppear {
                    withAnimation(Animation.easeIn(duration: 0.6).delay(0.4)) {
                        
                    }
                }
                .offset(y:-80)
            
            
            
            // Delete and hide view.
            Button(action: {
                
                AnimationShow.toggle()
                
            }) {
                
                Text("Delete")
                    .fontWeight(.bold)
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(20)
                    .shadow(radius: 3)
                
            }
            .offset(y:-90)
            
            Spacer()
        }
        .onAppear{
            myText = moodDetail.whatHappenText
            
        }
        .navigationBarTitle("Current Mood Status", displayMode: .inline)
        .edgesIgnoringSafeArea(.all)
    }
}

    
    
    struct MoodCard: View {
        let moodDetail: moodStructure
        
        @State var currentMoment: String
        @State var currentMood: [String] = []
        @State var currentActivity: [String] = []
        @State var peopleWith: [String] = []
        @State var currentPlace: [String] = []
        
        @Binding var isPresented: Bool
        @State  var AnimationShow : Bool
        @Environment(\.presentationMode) var presentationMode
        
        
        var columns: [GridItem] = [
            GridItem(.flexible(maximum: 80)),
            GridItem(.flexible(maximum: 80)),
            GridItem(.flexible(maximum: 80))
        
        ]
        
        var body: some View {
            
            
            ZStack{
                VStack{
                    // X Mark
                    HStack {
                        Spacer()
                        Button(action: {
                            
                            presentationMode.wrappedValue.dismiss()
                            AnimationShow.toggle()
                            
                            
                        }) {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }
                    .offset(y: 20)
                    .padding(.horizontal)
                    
                    
                    // Date
                    VStack(spacing:5){
                        Image(systemName:"calendar")
                            .font(.title)
                        Text("Saturday, May 9, 04:23")
                            .underline()
                            .font(.title3)
                    }
                    .foregroundColor(Color.white)
                    Divider()
                    
                }
                .padding(.top)
                .background(Color("Myblue"))
                .cornerRadius(20)
            }
            
            //face
            HStack {
                ZStack {
                    Circle()
                        .foregroundColor(Color(moodDetail.currentMoment))
                        .shadow(radius: 3)
                        .frame(width: 50, height: 50)
                    
                    Image(moodDetail.currentMoment)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .scaledToFill()
                }
                // Mood Text
                Text(moodDetail.currentMood[0])
                    .foregroundColor(Color(moodDetail.currentMoment))
                    .font(.title)
                    .fontWeight(.semibold)
            }
            //.animation(Animation.default.delay(1))
            
            
            TabView{
                FeelingsView(title: "Feelings", selectedArray: currentMood)
                
                FeelingsView(title: "Activities", selectedArray: currentActivity)
                
                FeelingsView(title: "People with", selectedArray: peopleWith)
                
                FeelingsView(title: "Place", selectedArray: currentPlace)

            }
           
            .frame(height: 230, alignment: .center)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .offset(y:-65)
            .onAppear(){
                setupAppearance()
            }
            
            
        }
        
        func setupAppearance() {
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.blue
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.red
            
            //UIColor.black.withAlphaComponent(0.2)
          }
    }
    

extension MoodCard {
    
    
    @ViewBuilder func FeelingsView(title:String,selectedArray:[String]) -> some View {
        
        VStack{
            
            HStack {
                Text(title)
                    .font(.subheadline)
                    .padding(10)
                Spacer()
            }
            
            HStack{
                
                LazyVGrid(
                    columns: columns,
                    alignment: .leading,
                    spacing: 15
                ) {
                    ForEach(selectedArray, id: \.self){ item in
                        Text(item)
                            .padding(.all, 10.0)
                            .contentShape(Rectangle())
                            .foregroundColor(Color("Mywhite"))
                            .background(Color("Myblue"))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                    }
                }.padding(.horizontal)
                
            }
                
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 0, maxHeight: 125)
            .background(SwiftUI.Color.white.edgesIgnoringSafeArea(.all))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.top,10)
            .padding(.horizontal,15)
            
        }
        
    }

    
    struct MoodDetail_Previews: PreviewProvider {
        static var previews: some View {
            MoodDetail(moodDetail: moodStructure(currentMood: ["Happy","Happy","Happy","Happy","Happy"], currentActivity: ["Coding"], peopleWith: ["Alone"], currentPlace: ["Home"], whatHappenText: "Nothing.", currentMoment: "5", selectedDate: ""), isPresented: .constant(false))
        }
    }

