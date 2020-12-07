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
    
    let moodArrayTest = ["Wonderful","Excited","Happy","Calm",
                         "I don't know","Stressed",
                         "Bored","Lonely","Tired",
                         "Overwhelmed","Anxious","More +"]
    
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
    
    // Varsa
    @State var currentMood: String = ""
    @State var currentActivity: String = ""
    @State var peopleWith: String = ""
    @State var currentPlace: String = ""
    //Date
    @State var currentMoment: String = ""
    @State var selectedDate: String = ""
    
    
    @ObservedObject var moodVM: MoodViewModel
    @Binding var  isPresented: Bool
    @State var selected = 0
    @State var tapped = ""
    @State var tapped2 = ""
    @State var tapped3 = ""
    @State var tapped4 = ""
    @State var flag = false
    
    @State var feelingsArray = ["1","2","3","4","5"]
    @State var filteredFeelingsArray = ["1","2","3","4","5"]
    
    
    
    var body: some View {
        
        NavigationView {
            // Mood Selective.
            
            ZStack (alignment: .bottom) {
                VStack(alignment: .center) {
                    
                    // How Are you Q
                    welcomingView(dateIs:selectedDate).animation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
                    
                    
                    Text("Hiiiii")
                        .onTapGesture{
                            flag.toggle()
                        }
                    
                    
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
                                    moodCheckSelection(selectedArray:moodArray,tapped: tapped, moodData: "", topic: self.currentMood)
                                        .onAppear() {
                                            self.selected = 0
                                        }
                                    
                                    
                                } else if self.selected == 1 {
                                    
                                    moodCheckSelection(selectedArray:activityArray,tapped: tapped2, moodData: "", topic: self.currentActivity)
                                        .onAppear() {
                                            self.selected = 1
                                        }
                                    
                                } else if self.selected == 2 {
                                    
                                    moodCheckSelection(selectedArray:peopleArray,tapped: tapped3, moodData: "", topic: self.peopleWith)
                                        .onAppear() {
                                            self.selected = 2
                                        }
                                    
                                } else if self.selected == 3 {
                                    
                                    moodCheckSelection(selectedArray:placeArray,tapped: tapped4, moodData: "", topic: self.currentPlace)
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
                                if self.currentPlace == "" {
                                    
                                    buttonView(currentMood: self.currentMood, currentActivity: self.currentActivity, peopleWith: self.peopleWith, currentPlace: self.currentPlace, currentMoment: self.currentMoment, moodVM: self.moodVM, isPresented: $isPresented, tag: nil)
                                }
                            }
                        }
                        
                    }
                    .animation(.spring())
                    Spacer()
                }
                
                if flag {
                    Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("label")
                        Button(action: {
                            self.flag.toggle()
                        }) {
                            Text("Close")
                        }
                    }
                    .frame(width:UIScreen.main.bounds.width,height: 300)
                    .background(Color.primary.colorInvert()).cornerRadius(50)
                    
                }
                
            }
            .navigationBarTitle("Add Mode",displayMode: .inline)
            .edgesIgnoringSafeArea(.bottom)
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

struct moodCheckSelection : View {
    
    @State var selectedArray : [[String]] = [[]]
    @State var tapped : String
    @State var moodData : String
    @State var topic : String
    
    
    var body : some View {
        
        
        
        VStack (spacing: 5){
            ForEach(selectedArray, id: \.self) { row in
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
                                self.tapped = moodData
                                self.topic = moodData
                                print(moodData)
                                print(self.topic)
                            }
                    }
                }
            }
        }
        
    }
    
}

struct welcomingView: View {
    
    @State private var selectedDate = Date()
    @State var dateIs : String = ""
    @State var flag = false
    
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
                
                Text("Date")
                    .onTapGesture {
                        flag.toggle()
                    }
                /*DatePicker("", selection: $selectedDate)
                 
                 //.datePickerStyle(DefaultDatePickerStyle())
                 .accentColor(Color("Myblue"))
                 .labelsHidden()*/
                
            }
            //.offset(y: -15.0)
            .onAppear() {
                // dateIs = Text("Task due date: \(selectedDate, formatter: Self.taskDateFormat)")
                print(dateIs)
            }.padding()
            
        }.padding(.top)
        
        
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
        
        VStack {
            Image(systemName: "chevron.right.circle.fill")
                .foregroundColor(Color("Myblue"))
                .font(.system(size: 50))
            Text("Done")
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


