//
//  CardsView.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 02/12/2021.
//

import Foundation
import SwiftUI



struct MoodCard: View {
    
    @State var currentMood: [String]
    @State var currentActivity: [String]
    @State var peopleWith: [String]
    @State var currentPlace: [String]
    @State var whatHappenText: String
    @State var currentMoment: String
    @State var decodedDate: Date
    @State var selectedDate: String
    @State var time: String
    @State var year: String
    @State var month: String
    @State var day: String
    @State var moodName =   [NSLocalizedString("", comment: "")
                            ,NSLocalizedString("Awful", comment: ""),
                             NSLocalizedString("Meh", comment: ""),
                             NSLocalizedString("OK", comment: ""),
                             NSLocalizedString("Good", comment: ""),
                             NSLocalizedString("Great", comment: "")]

    
    
    var body: some View {
        
        ZStack {
            // Rectangle
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(.white)
                .frame(height: 140)
                //.shadow(radius: 5)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)

            
            // Content
            HStack {
                
                // Date
                VStack {
                    Text(day)
                        .font(.system(size: 15))
                    Text(month)
                        .font(.system(size: 15))

                    Divider()
                        .frame(width:15)
                    Text(time)
                        .font(.system(size: 15))

                    
                }
                .padding(.top)
                .frame(minWidth:60,maxWidth:60)
                .offset(x:3)
                
                Divider()
                
                
                VStack{
                    HStack{
                        //face
                        ZStack {
                            Circle()
                                .foregroundColor(Color(currentMoment))
                                .shadow(radius: 3)
                                .frame(width: 50, height: 50)
                            
                            
                            Image(currentMoment)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .scaledToFill()
                        }
                        
                        // Mood Text
                        
                        if currentMoment.isEmpty {
                            Text("")
                        } else {
                            Text(moodName[Int(currentMoment)!]).font(.headline)                   .foregroundColor(Color(currentMoment))

                        }
                        
                        
                        Spacer()
                        
                    }
                    .offset(y:10)
                    
                    .font(.system(size: 24))

                    
                    // Things
                    HStack{
                        if currentActivity.isEmpty {
                            Text("")
                        } else {
                            Text(currentActivity[0])
                                .font(.callout)
                                .lineLimit(0)
                            Divider().frame(height: 30)
                        }
                        
                        if peopleWith.isEmpty {
                            Text("")
                            Divider().frame(height: 30)
                        } else {
                            Text(peopleWith[0])
                                .lineLimit(0)
                                .font(.callout)
                            Divider().frame(height: 30)
                        }
                        
                        if currentPlace.isEmpty {
                            Text("")
                            Spacer()
                            
                        } else {
                            Text(currentPlace[0])
                                .font(.callout)
                                .lineLimit(0)
                            Spacer()
                        }
                        
                    }
                    .font(.system(size: 17))
                    .lineLimit(0)
                    
                }
                
            }
        }
        
    }
    
    
    
}


struct ThoughtRecordCard: View {

    
    @State var trigger : String
    @State var autoThought : String
    @State var emotions : String
    @State var EFT : String
    @State var EAT : String
    @State var alterThought : String
    @State var outcome : String
    @State var time: String
    @State var year: String
    @State var month: String
    @State var day: String
    @State var selectedDate : String
    @State var decodedDate: Date

    

    
    
    var body: some View {
        
        ZStack {
            // Rectangle
            RoundedRectangle(cornerRadius: 10.0)
                .foregroundColor(.white)
                .frame(height: 125)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
            
                            
                VStack(alignment: .leading){
                    HStack {
                        VStack(alignment:.leading,spacing:5) {
                            Text("Trigger/Event")
                                .underline()
                                .foregroundColor(Color("Myblue"))
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                            .opacity(0.5)
                            VStack() {
                                Text(trigger)
                                    .font(.system(size: 15))
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        
                        Image("CBT")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)

                    }
                   
                    
                    Spacer()
                    Divider()
                    Text(selectedDate)
                        .font(.system(size: 13))

                    
                }
                .padding(10)
                .frame(height: 135)

            

        }//.padding(.horizontal,40)
        
    }
    
    
    
}



struct TherapistCardView_Previews: PreviewProvider {
    static var previews: some View {
        MoodCard(currentMood: ["1"], currentActivity: [""], peopleWith: [""], currentPlace: [""], whatHappenText: "", currentMoment: "", decodedDate: Date(), selectedDate: "", time: "", year: "", month: "", day: "")
    }
}
