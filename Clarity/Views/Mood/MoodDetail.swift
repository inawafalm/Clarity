//
//  MoodDetail.swift
//  life
//
//  Created by Nawaf Almutairi on 4/27/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI


struct MoodDetail: View {
    
    
    var moodDetail = moodStructure(currentMood: [""], currentActivity: [""], peopleWith: [""], currentPlace: [""], journaling: "", currentMoment: "",decodedDate: Date(), selectedDate: "", time: "", year: "", month: "", day: "")
    
    @State var myText = ""
    @Binding var  isPresented: Bool
    @State private var AnimationShow = false
    @Environment(\.presentationMode) var presentationMode

    
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    var body: some View {
        
            ScrollView {
                
                // Header
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
                        Text(moodDetail.selectedDate)
                            .underline()
                            .font(.system(size: 20))
                    }
                    .foregroundColor(Color.white)
                    Divider()
                    
                }
                .padding(.top)
                .background(Color("Myblue"))
                .cornerRadius(20)
                // Header Ends

                
                // Body
                MoodCardDetail(currentMoment: moodDetail.currentMoment, currentMood: moodDetail.currentMood, currentActivity: moodDetail.currentActivity, peopleWith: moodDetail.peopleWith, currentPlace: moodDetail.currentPlace)
                   // .opacity(AnimationShow ? 1 : 0)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 0.6).delay(0.4)) {
                            //self.AnimationShow.toggle()
                            print(moodDetail)
                        }
                    }
                
                // Journaling
                
                Text("Journaling")
                    .foregroundColor(Color("Myblue"))
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .opacity(0.5)
                Text(moodDetail.journaling)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 200, maxHeight: 600,alignment: .topLeading)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding()
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 0.6).delay(0.4)) {
                        }
                    }
                
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                myText = moodDetail.journaling
                
            }
            .navigationBarTitle("Current Mood Status", displayMode: .inline)
            .multilineTextAlignment(.center)

    }
    
}


struct MoodCardDetail: View {
    
    
    @State var currentMoment: String
    @State var currentMood: [String] = []
    @State var currentActivity: [String] = []
    @State var peopleWith: [String] = []
    @State var currentPlace: [String] = []

    
    var body: some View {
        
        //face
        HStack {
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
            
            if currentMood.isEmpty {
                
            } else {
                Text(currentMood[0])
                    .foregroundColor(Color(currentMoment))
                    .font(.system(size: 28))
                    .bold()
            }
           

        }
     
            
        VStack(spacing:-15) {
            DetailScrollView(title: NSLocalizedString("Feelings", comment: ""), selectedArray: currentMood)
            DetailScrollView(title: NSLocalizedString("Activity",comment: ""), selectedArray: currentActivity)
            DetailScrollView(title: NSLocalizedString("With", comment: ""), selectedArray: peopleWith)
            DetailScrollView(title: NSLocalizedString("Place", comment: ""), selectedArray: currentPlace)
        }.offset(y:-30)
        
            Divider()

    }
    
}


struct DetailScrollView: View {
    
    @State var title = ""
    @State var selectedArray : [String] = []
    
    var body: some View {
        VStack() {
            HStack {
                
                Text(title)
                    .foregroundColor(Color("Myblue"))
                    .font(.system(size: 28))
                    .bold()
                    .offset(y:20)
                    .padding(.leading)
                Spacer()
            }.opacity(0.5)
            
            HStack() {
                Spacer()
                ScrollView (.horizontal,showsIndicators:false) {
                    HStack (spacing: 16){
                        ForEach(selectedArray, id:\.self) { item in
                            Text(item)
                                .font(.system(size: 18))
                                .padding(.all, 10.0)
                                .contentShape(Rectangle())
                                .foregroundColor(Color("Mywhite"))
                                .background(Color("Myblue"))
                                .cornerRadius(10)
                                .shadow(radius:1 , x: 0, y: 2)
                        }
                        .padding(5)
                        
                    }
                }
                .frame(width: 360)
            }
        }
    }
}

struct MoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            DetailScrollView(title: "Title", selectedArray: ["dd1","2dsf"])
            
//
//            MoodCheckView(isPresented: .constant(false))
//                .previewDevice(PreviewDevice(rawValue: "iPhone 12 pro"))
//                .previewDisplayName("iPhone 12 pro")
//
//            MoodCheckView(isPresented: .constant(false))
//                .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
//                .previewDisplayName("iPhone 12 mini")
//
//            MoodCheckView(isPresented: .constant(false))
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//                .previewDisplayName("iPhone 8")
            
        }
        
    }
}
