//
//  describeView.swift
//  life
//
//  Created by Nawaf Almutairi on 2/1/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI

//TODO
// change background to white. DONE
// change the add button. 
// maybe comeup with new design

struct moodHandler: Codable {
    
    let currentMood: String
    let currentActivity: String
    let peopleWith: String
    let currentPlace: String
    let whatHappenText: String
    
    init(currentMood: String,
         currentActivity:String,
         peopleWith:String,
         currentPlace:String,
         whatHappenText:String) {
        self.currentMood = currentMood
        self.currentActivity = currentActivity
        self.peopleWith = peopleWith
        self.currentPlace = currentPlace
        self.whatHappenText = whatHappenText
    }
}

struct describeView: View {
    
    @State var currentMood: String
    @State var currentActivity: String
    @State var peopleWith: String
    @State var currentPlace: String
    @State var currentMoment: String
    
    @State private var input = "What Happen ?"
    @Binding  var  isPresented: Bool
    @ObservedObject var moodVM: MoodViewModel
    
    var body: some View {
            VStack{
                
                Image("MoodTrack")
                    .resizable()
                    .frame(width: 100 , height: 100)
                
                Text("journaling. It's simply writing down your thoughts and feelings to understand them more clearly. And if you struggle with stress, depression, or anxiety, keeping a journal is a great idea. It can help you gain control of your emotions and improve your mental health.")
                    .multilineTextAlignment(.center)
                    .padding(5)
                
                TextEditor(text: $input)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    .frame(height: 300)
                    .shadow(radius: 5)

                Button(action: {
                    self.isPresented = false
                    let item = moodStructure(currentMood: self.currentMood, currentActivity: self.currentActivity, peopleWith: self.peopleWith, currentPlace: self.currentPlace, whatHappenText: self.input, currentMoment: self.currentMoment, selectedDate: "")
                    print(item)
                    self.moodVM.moodArray.append(item)
                    
                }, label: {
                    Text("Add")
                        .foregroundColor(.white)
                        .buttonStyle(buttonChoiceStyle())
                    .shadow(radius: 3)
                })
                Spacer()
            }.padding(.vertical,50)
        
    }
}

#if DEBUG
struct describeView_Previews: PreviewProvider {
    @State var isPresentedPreview = false
    static var previews: some View {
        describeView(currentMood: "Happy", currentActivity: "working", peopleWith: "Friends", currentPlace: "School", currentMoment: "", isPresented: .constant(false), moodVM: MoodViewModel())
    }
}
#endif
