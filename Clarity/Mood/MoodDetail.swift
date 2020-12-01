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
    
    var moodDetail = moodStructure(currentMood: "", currentActivity: "", peopleWith: "", currentPlace: "", whatHappenText: "", currentMoment: "", selectedDate: "")
    @State var myText = ""
    @Binding var  isPresented: Bool
    @State private var AnimationShow = false
    @State private var toggle = false
    
    @State var textPassed = ""
    
    var body: some View {
       
        
            VStack {
                
                MoodCard(moodDetail: moodDetail, isPresented: $isPresented, AnimationShow: AnimationShow)
                        .opacity(AnimationShow ? 1 : 0)
                       // .offset(y: AnimationShow ? 0 : -100)
                        //.offset(y: isPresented ? 0 : -100)
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
    @Binding var isPresented: Bool
    @State  var AnimationShow : Bool
    @Environment(\.presentationMode) var presentationMode

    
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
            .padding(.top,50)
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
            Text(moodDetail.currentMood)
                .foregroundColor(Color(moodDetail.currentMoment))
                .font(.title)
                .fontWeight(.semibold)
        }
        //.animation(Animation.default.delay(1))
        
        
        
        // Things
        HStack{
            Text(moodDetail.currentActivity)
            
            Divider().frame(height: 30)
            Text(moodDetail.peopleWith)
            
            Divider().frame(height: 30)
            Text(moodDetail.currentPlace)
            
        }.font(.title3)
        .padding(.top,-10)
       
        
    }
}

extension View {
    func hiddenConditionally(isHidden: Bool) -> some View {
        isHidden ? AnyView(self.hidden()) : AnyView(self)
    }
}

struct MoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        MoodDetail(moodDetail: moodStructure(currentMood: "Happy", currentActivity: "Coding", peopleWith: "Alone", currentPlace: "Home", whatHappenText: "Nothing.", currentMoment: "5", selectedDate: ""), isPresented: .constant(false))
    }
}

