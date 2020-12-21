//
//  MoodCheckView2.swift
//  life
//
//  Created by Nawaf Almutairi on 5/18/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//
import SwiftUI

// TODO
// Date view, maybe it shows from buttom page.
// background of button to white. // DONE
struct Selectable: Hashable {
    var item: String
    var isSelected: Bool = false
}


struct MoodCheckView: View {
    
    // Arrays start here.
    let moodArray =  [
        ["Wonderful","Excited","Happy"],
        ["Calm","I don't know","Stressed"],
        ["Bored","Lonely","Tired"],
        ["Overwhelmed","Anxious","More +"]
    ]
    

    let activityArray =  [
        ["Working","Watching a movie"],
        ["Drinking coffee","Trying to sleep"],
        ["Studying","Excercising"]
        /* ["Hanging with friends","Eating"],
         ["Walking","Going to work"],
         ["nothing","Going to school","+ More"]*/
    ]
    
    let peopleArray =  [
        ["Teacher","Friend(s)","Family"],
        ["Lover","Father","No one"],
        ["Colleague(s)","Mother","Pet"]
        /*  ["Spouse","Child","Children"],
         ["Stranger","Boss","+ More"]*/
    ]
    
    let placeArray =  [
        ["Home","School","Cafe shop"],
        ["outside","gym","..."]
        /* ["...","...","..."],
         ["...","...","More +"]*/
    ]
   
    
    // Vars
    @State var currentMoment: String = ""
    @State var currentMood: [String] = []
    @State var currentActivity: [String] = []
    @State var peopleWith: [String] = []
    @State var currentPlace: [String] = []
    //Date
    
    @ObservedObject var moodVM: MoodViewModel
    @Binding var  isPresented: Bool
    @State var selected = 0
    @State var flag = false
    @State var selectedDate = Date()
    @State var holdingDate = Date()
    @State var feelingsArray = ["1","2","3","4","5"]
    @State var filteredFeelingsArray = ["1","2","3","4","5"]
    @State var tag:Int? = nil
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        
        NavigationView {
            // Mood Selective.
            
            ZStack (alignment: .bottom) {
                VStack(alignment: .center) {
                    
                    //welcomingView(flag: $flag)
                    Text("How are you?")
                        .font(.title)
                        .foregroundColor(Color("Myblack"))
                        .padding(.top,50)
                    
                    HStack {
                        Image(systemName:"calendar")
                            .font(.title2)
                            .foregroundColor(Color("Myblue"))
                        Text(MoodCheckView.formatter.string(from: selectedDate))
                            .font(.headline)
                            .foregroundColor(Color("Myblue"))
                            .underline()
                            .onTapGesture{
                                self.flag.toggle()
                            }
                    }
                    .padding(5)
                    
                    
                    // HStack has emoji
                    HStack{
                        ForEach (filteredFeelingsArray, id:\.self) {item in
                            EmojiMoodButton(colorName: item)
                                .onTapGesture {
                                    self.currentMoment = "\(item)"
                                    //print(tapped)
                                    if filteredFeelingsArray.count == 1 {
                                        filteredFeelingsArray = feelingsArray
                                    } else {
                                        filteredFeelingsArray = filteredFeelingsArray.filter {$0 == "\(item)"}
                                    }
                                }
                        }
                    }.animation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
                    
                    // Selection
                    VStack{
                        if self.currentMoment == "" {
                        } else {
                            moodCheckingBar(selected: self.$selected)
                                .padding()
                                .animation(Animation.easeIn.delay(0.3))
                            VStack {
                                if self.selected == 0 {
                                    
                                    VStack (spacing: 5){
                                        ForEach(moodArray, id: \.self) { row in
                                            HStack (spacing: 5){
                                                ForEach(row, id: \.self) { moodData2 in
                                                    
                                                    // Make it in Main struct
                                                    MultipleSelectionRow(text: moodData2, isSelected: currentMood.contains(moodData2)){
                                                        
                                                        if currentMood.contains(moodData2) {
                                                            currentMood.removeAll(where: { $0 == moodData2 })
                                                        }
                                                        else {
                                                            currentMood.append(moodData2)
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                        }
                                        
                                    }
                                    .onAppear() {
                                        self.selected = 0
                                    }
                                    
                                } else if self.selected == 1 {
                                    VStack (spacing: 5){
                                        ForEach(activityArray, id: \.self) { row in
                                            HStack (spacing: 5){
                                                ForEach(row, id: \.self) { moodData2 in
                                                    
                                                    // Make it in Main struct
                                                    MultipleSelectionRow(text: moodData2, isSelected: currentActivity.contains(moodData2)){
                                                        
                                                        if currentActivity.contains(moodData2) {
                                                            currentActivity.removeAll(where: { $0 == moodData2 })
                                                        }
                                                        else {
                                                            currentActivity.append(moodData2)
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                        }
                                        
                                    }
                                    .onAppear() {
                                        self.selected = 1
                                    }
                                } else if self.selected == 2 {
                                    VStack (spacing: 5){
                                        ForEach(peopleArray, id: \.self) { row in
                                            HStack (spacing: 5){
                                                ForEach(row, id: \.self) { moodData2 in
                                                    
                                                    // Make it in Main struct
                                                    MultipleSelectionRow(text: moodData2, isSelected: peopleWith.contains(moodData2)){
                                                        
                                                        if peopleWith.contains(moodData2) {
                                                            peopleWith.removeAll(where: { $0 == moodData2 })
                                                        }
                                                        else {
                                                            peopleWith.append(moodData2)
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                        }
                                        
                                    }
                                    .onAppear() {
                                        self.selected = 2
                                    }
                                    
                                } else if self.selected == 3 {
                                    VStack (spacing: 5){
                                        ForEach(placeArray, id: \.self) { row in
                                            HStack (spacing: 5){
                                                ForEach(row, id: \.self) { moodData2 in
                                                    
                                                    // Make it in Main struct
                                                    MultipleSelectionRow(text: moodData2, isSelected: currentPlace.contains(moodData2)){
                                                        
                                                        if currentPlace.contains(moodData2) {
                                                            currentPlace.removeAll(where: { $0 == moodData2 })
                                                        }
                                                        else {
                                                            currentPlace.append(moodData2)
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                
                                            }
                                        }
                                        
                                    }
                                    .onAppear() {
                                        self.selected = 3
                                    }
                                }
                            }
                            .padding()
                            .background(Color("Myblue"))
                            .cornerRadius(20)
                            
                            if selected < 3 {
                                
                                VStack {
                                    Image(systemName: "chevron.right.circle.fill")
                                        .foregroundColor(Color("Myblue"))
                                        .font(.system(size: 50))
                                    Text("Next")
                                        .foregroundColor(Color("Myblack"))
                                        .font(.footnote)
                                        .bold()
                                }
                                .onTapGesture {
                                    self.selected = selected + 1
                                }
                            } else {
                                if self.currentPlace.isEmpty {
                                    VStack {
                                        Image(systemName: "chevron.right.circle.fill")
                                            .foregroundColor(Color.gray)
                                            .font(.system(size: 50))
                                        Text("Continue")
                                            .foregroundColor(Color("Myblack"))
                                            .font(.footnote)
                                            .bold()
                                    }
                                    
                                } else {
                                    
                                    buttonView(currentMoment: "", currentMood: [""], currentActivity: [""], peopleWith: ["String"], currentPlace: ["String"], moodVM: self.moodVM, isPresented: $isPresented, tag: nil)
                                }
                             }
                        }
                        //
                    }
                    .animation(.spring())
                    Spacer()
                }
                if flag {
                    //CustomCalender(flag: $flag,selectedDate:selectedDate).zIndex(0)
                    Color.gray.opacity(0.7).edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.flag.toggle()
                        }
                    VStack {
                        HStack {
                            Button(action: {
                                self.flag.toggle()
                            }) {
                                Text("Cancel")
                                    .foregroundColor(Color.white)
                                
                            }
                            .padding()
                            .padding(.horizontal,5)
                            Spacer()
                            Button(action: {
                                self.flag.toggle()
                                self.selectedDate = self.holdingDate
                            }) {
                                Text("Done")
                                    .foregroundColor(Color.white)
                                    .bold()
                            }
                            .padding()
                            .padding(.horizontal,5)
                            
                        }.background(Color("Myblue"))
                        
                        DatePicker("", selection: $holdingDate)
                            .datePickerStyle(WheelDatePickerStyle())
                            .labelsHidden()
                        Spacer()
                        
                    }
                    .transition(.move(edge: .bottom))
                    .frame(width:UIScreen.main.bounds.width,height: 300)
                    .background(Color.primary.colorInvert()).cornerRadius(50)
                    .zIndex(0)
                }
                
            }
            .navigationBarTitle("Add Mode",displayMode: .inline)
            .edgesIgnoringSafeArea(.bottom)
            .animation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
        }
        
        
    }
    
    
    
}



struct MoodCheckView_Previews: PreviewProvider {
    static var previews: some View {
        MoodCheckView(moodVM: MoodViewModel(), isPresented: .constant(false))
    }
}

struct moodCheckingBar : View {
    
    @Binding var selected : Int
    
    var body : some View{
        HStack {
            
            // Mood
            Button(action: {
                self.selected = 0
            })
            {
                Text("Mood")
                    .bold()
                    .padding(.vertical,12)
                    .padding(.horizontal,15)
                    .background(self.selected == 0 ?  Color("Mywhite") : Color.clear)
                    .clipShape(Capsule())
                
            }.foregroundColor(self.selected == 0 ? Color("Myblue") : Color("Mywhite"))
            
            // Activity
            Button(action: {
                self.selected = 1
            })
            {
                Text("Activity")
                    .bold()
                    .padding(.vertical,12)
                    .padding(.horizontal,15)
                    .background(self.selected == 1 ?  Color("Mywhite") : Color.clear)
                    .clipShape(Capsule())
            }.foregroundColor(self.selected == 1 ? Color("Myblue") : Color("Mywhite"))
            
            Button(action: {
                self.selected = 2
            })
            {
                Text("People")
                    .bold()
                    .padding(.vertical,12)
                    .padding(.horizontal,15)
                    .background(self.selected == 2 ?  Color("Mywhite") : Color.clear)
                    .clipShape(Capsule())
            }.foregroundColor(self.selected == 2 ? Color("Myblue") : Color("Mywhite"))
            
            Button(action: {
                self.selected = 3
            })
            {
                Text("Place")
                    .bold()
                    .padding(.vertical,10)
                    .padding(.horizontal,15)
                    .background(self.selected == 3 ?  Color("Mywhite") : Color.clear)
                    .clipShape(Capsule())
            }.foregroundColor(self.selected == 3 ? Color("Myblue") : Color("Mywhite"))
            
        }
        .padding(4).background(Color("Myblue"))
        .clipShape(Capsule())
        .animation(Animation.default)
        
    }
}


struct MultipleSelectionRow: View {
    @State var text : String
    var isSelected: Bool
    var action: () -> Void
    
    
    var body: some View {
        Button(action: self.action) {
            Text(text)
                .padding(.all, 10.0)
                .contentShape(Rectangle())
                .foregroundColor(isSelected ? Color("Mywhite"): Color("Myblue"))
                .background(isSelected ? Color("Myblue"): Color("Mywhite"))
                .cornerRadius(20)
                .shadow(radius: 5)
        }
    }
}


struct CustomCalender: View {
    
    @Binding var flag : Bool
    @State var selectedDate = Date()
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        
        Color.gray.opacity(0.7).edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.flag.toggle()
            }
        VStack {
            
            Spacer()
            DatePicker("", selection: $selectedDate)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            Button(action: {
                self.flag.toggle()
            }) {
                Text("Done")
            }
            .padding()
        }
        .transition(.move(edge: .bottom))
        .frame(width:UIScreen.main.bounds.width,height: 300)
        .background(Color.primary.colorInvert()).cornerRadius(50)
    }
}

struct buttonView: View {
    
    @State var currentMoment: String = ""
    @State var currentMood: [String] = []
    @State var currentActivity: [String] = []
    @State var peopleWith: [String] = []
    @State var currentPlace: [String] = []
    @ObservedObject var moodVM = MoodViewModel()
    @Binding var  isPresented: Bool
    @State var tag:Int? = nil
    
    var body: some View {
        
       NavigationLink(destination: describeView(currentMoment: self.currentMoment, currentMood: self.currentMood, currentActivity: self.currentActivity, peopleWith: self.peopleWith, currentPlace: self.currentPlace, isPresented: self.$isPresented, moodVM: self.moodVM), tag: 1, selection: $tag) {
            EmptyView()
        }
        
        VStack {
            Image(systemName: "chevron.right.circle.fill")
                .foregroundColor(Color("Myblue"))
                .font(.system(size: 50))
            Text("Done")
                .foregroundColor(Color("Myblack"))
                .font(.footnote)
                .bold()
        }
        .padding(8)
        .onTapGesture(perform: {
            tag = 1
        })
    }
}

// Customizing Emoji.
struct EmojiMoodButton: View {
    var colorName: String
    var textArray = ["","Terriable","Meh","OK","Good","Great"]
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(Color(colorName))
                    .shadow(radius: 3)
                    .frame(width: 50, height: 50)
                
                Image(colorName)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .scaledToFill()
            }
            Text(textArray[Int(colorName) ?? 0])
                .foregroundColor(Color("Myblack"))
                .font(.footnote)
                .fontWeight(.bold)
            
        }
    }
}
