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
    
    let textArray = [
        "What do you feel right now ?",
        "What are you doing ?",
        "Who  are you with ?",
        "Where are you ?"]
    
    // First
    @State var buttonText1: String = ""
    @State var currentMood: String = ""
    @State var expandMood = false
    
    //Second
    @State var buttonText2: String = ""
    @State var currentActivity: String = ""
    @State var expandActivity = false
    
    //Third
    @State var buttonText3: String = ""
    @State var peopleWith: String = ""
    @State var expandPeopleWith = false
    
    // Fourth
    @State var buttonText4: String = ""
    @State var currentPlace: String = ""
    @State var expandCurrentPlace = false
    
    @State var currentMoment: String = ""
    @State var selectedDate: String = ""
    
    // Progress
    @State var precent: CGFloat = 0
    @State var precent2 : CGFloat = 0
    @State var precent3 : CGFloat = 0
    @State var precent4 : CGFloat = 0
    @State var precent5 : CGFloat = 0
    @State var precentBar: CGFloat = 0
    @State var precentBar2 : CGFloat = 0
    @State var precentBar3 : CGFloat = 0
    @State var precentBar4 : CGFloat = 0
    
    @ObservedObject var moodVM: MoodViewModel
    @Binding var  isPresented: Bool
    @State var selected = 0
    @State var tapped = ""
    @State var tapped2 = ""
    @State var tapped3 = ""
    @State var tapped4 = ""
    
    @State var feelingsArray = ["1","2","3","4","5"]
    @State var filteredFeelingsArray = ["1","2","3","4","5"]
    
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center, spacing: 20){
                
                
                // Progress Bar
                HStack(){
                    // First Step
                    
                    
                    CircleProgress(precent: self.precent)
                    BarProgress(value:self.precentBar)
                    
                    //Second Step
                    CircleProgress(precent: self.precent2)
                    BarProgress(value:self.precentBar2)
                    
                    // Third Step
                    CircleProgress(precent: self.precent3)
                    BarProgress(value:self.precentBar3)
                    
                    //Forth
                    CircleProgress(precent: self.precent4)
                    BarProgress(value:self.precentBar4)
                    
                    //Fifth
                    CircleProgress(precent: self.precent5)
                    
                    
                }
                
                .padding(.horizontal,20)
                .padding(.top,30)
                
                //Spacer()
                
                // Mood Selective.
                VStack(alignment: .center, spacing: 10) {
                    
                    // How Are you Q
                    welcomingView(dateIs:selectedDate).animation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
                    
                    // HStack has emoji
                    HStack{
                        ForEach (filteredFeelingsArray, id:\.self) {item in
                            EmojiMoodButton(colorName: item)
                                .onTapGesture {
                                    self.currentMoment = "\(item)"
                                    print(tapped)
                                    if filteredFeelingsArray.count == 1 {
                                        filteredFeelingsArray = feelingsArray
                                    } else {
                                        filteredFeelingsArray = filteredFeelingsArray.filter {$0 == "\(item)"}
                                        self.precent = 100
                                        self.precentBar = 35
                                    }
                                }
                        }
                    }.animation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
                    
                    
                    VStack{
                        if self.currentMoment == "" {
                            
                            
                        } else {
                            moodCheckingBar(selected: self.$selected)
                                .padding()
                                .animation(Animation.easeIn.delay(0.3))
                            VStack {
                                if self.selected == 0 {
                                    VStack (spacing: 5){
                                        ForEach(self.moodArray, id: \.self) { row in
                                            HStack (spacing: 5){
                                                ForEach(row, id: \.self) { moodData in
                                                    Text(moodData)
                                                        .padding(.all, 10.0)
                                                        .contentShape(Rectangle())
                                                        .foregroundColor(self.tapped == moodData ? Color("Mywhite"): Color("Myblue"))
                                                        .background(self.tapped == moodData ? Color("Myblue"): Color("Mywhite"))
                                                        .cornerRadius(20)
                                                        .shadow(radius: 5)
                                                        .onTapGesture {
                                                            self.currentMood = moodData
                                                            self.tapped = moodData
                                                            print(moodData)
                                                            print(self.currentActivity)
                                                            self.expandActivity.toggle()
                                                            self.precent2 = 100
                                                            self.precentBar2 = 35
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                                self.selected = self.selected + 1
                                                            }
                                                            
                                                        }
                                                    
                                                }
                                            }
                                        }
                                    }
                                    
                                } else if self.selected == 1 {
                                    VStack (spacing: 5){
                                        ForEach(self.activityArray, id: \.self) { row in
                                            HStack (spacing: 5){
                                                ForEach(row, id: \.self) { moodData in
                                                    Text(moodData)
                                                        .padding(.all, 10.0)
                                                        .contentShape(Rectangle())
                                                        .foregroundColor(self.tapped2 == moodData ? Color("Mywhite"): Color("Myblue"))
                                                        .background(self.tapped2 == moodData ? Color("Myblue"): Color("Mywhite"))
                                                        .cornerRadius(20)
                                                        .shadow(radius: 5)
                                                        .onTapGesture {
                                                            self.tapped2 = moodData
                                                            self.currentActivity = moodData
                                                            print(moodData)
                                                            print(self.currentActivity)
                                                            self.expandActivity.toggle()
                                                            self.precent3 = 100
                                                            self.precentBar3 = 35
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                                self.selected = self.selected + 1
                                                            }
                                                            
                                                        }
                                                }
                                            }
                                        }
                                    }
                                } else if self.selected == 2 {
                                    VStack (spacing: 5){
                                        ForEach(self.peopleArray, id: \.self) { row in
                                            HStack (spacing: 5){
                                                ForEach(row, id: \.self) { moodData in
                                                    Text(moodData)
                                                        .padding(.all, 10.0)
                                                        .contentShape(Rectangle())
                                                        .foregroundColor(self.tapped3 == moodData ? Color("Mywhite"): Color("Myblue"))
                                                        .background(self.tapped3 == moodData ? Color("Myblue"): Color("Mywhite"))
                                                        .cornerRadius(20)
                                                        .shadow(radius: 5)
                                                        .onTapGesture {
                                                            self.tapped3 = moodData
                                                            self.peopleWith = moodData
                                                            print(moodData)
                                                            print(self.peopleWith)
                                                            self.expandPeopleWith.toggle()
                                                            self.precent4 = 100
                                                            self.precentBar4 = 35
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                                self.selected = self.selected + 1
                                                            }
                                                            
                                                        }
                                                }
                                            }
                                        }
                                    }
                                } else if self.selected == 3 {
                                    VStack (spacing: 5){
                                        ForEach(self.placeArray, id: \.self) { row in
                                            HStack (spacing: 5){
                                                ForEach(row, id: \.self) { moodData in
                                                    Text(moodData)
                                                        .padding(.all, 10.0)
                                                        .contentShape(Rectangle())
                                                        // .foregroundColor(Color("Myblue"))
                                                        .foregroundColor(self.tapped4 == moodData ? Color("Mywhite"): Color("Myblue"))
                                                        .background(self.tapped4 == moodData ? Color("Myblue"): Color("Mywhite"))
                                                        .cornerRadius(20)
                                                        .shadow(radius: 5)
                                                        .onTapGesture {
                                                            self.tapped4 = moodData
                                                            self.currentPlace = moodData
                                                            print(moodData)
                                                            print(self.currentPlace)
                                                            self.precent5 = 100
                                                        }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(Color("Myblue"))
                            .cornerRadius(20)
                        }
                    }
                    .animation(.spring())
                    if self.currentPlace != "" {
                        
                        buttonView(currentMood: self.currentMood, currentActivity: self.currentActivity, peopleWith: self.peopleWith, currentPlace: self.currentPlace, currentMoment: self.currentMoment, moodVM: self.moodVM, isPresented: $isPresented, tag: nil)
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("Add Mode",displayMode: .inline)
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
                    //.resizable()
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
        .padding(8).background(Color("Myblue"))
        .clipShape(Capsule())
        .animation(Animation.default)
        
    }
}

struct welcomingView: View {
    
    @State private var selectedDate = Date()
    @State var dateIs : String = ""
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text("How are you?")
                .foregroundColor(Color("Myblack"))
                .font(.largeTitle)
            HStack{
                Image(systemName:"calendar")
                    .font(.title2)
                    .foregroundColor(Color("Myblue"))
                DatePicker("", selection: $selectedDate).datePickerStyle(DefaultDatePickerStyle())
                    .accentColor(Color("Myblue"))
                    .labelsHidden()
            }
            
            .onAppear() {
                // dateIs = Text("Task due date: \(selectedDate, formatter: Self.taskDateFormat)")
                print(dateIs)
            }
        }.padding()
    }
}

struct buttonView: View {
    
    @State var currentMood: String
    @State var currentActivity: String
    @State var peopleWith: String
    @State var currentPlace: String
    @State var currentMoment: String
    @ObservedObject var moodVM = MoodViewModel()
    @Binding var  isPresented: Bool
    @State var tag:Int? = nil
    
    var body: some View {
        
        NavigationLink(destination: describeView(currentMood: self.currentMood, currentActivity: self.currentActivity, peopleWith: self.peopleWith, currentPlace: self.currentPlace, currentMoment: self.currentMoment, isPresented: self.$isPresented, moodVM: self.moodVM), tag: 1, selection: $tag) {
            EmptyView()
        }
        
        VStack(spacing: 12) {
            Image(systemName: "chevron.right.circle.fill")
                .foregroundColor(Color("Myblue"))
                .font(.system(size: 50))
            Text("Continue")
                .foregroundColor(Color("Myblack"))
                .font(.footnote)
                .bold()
        }.padding()
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
