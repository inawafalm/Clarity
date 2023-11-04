//
//  MoodCheckView2.swift
//  life1`q
//  Created by Nawaf Almutairi on 5/18/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//
import SwiftUI




struct MoodCheckView: View {
    
    
    
    // Vars
    @State var currentMoment: String = ""
    @State var currentMood: [String] = []
    @State var currentActivity: [String] = []
    @State var peopleWith: [String] = []
    @State var currentPlace: [String] = []
    
    //Date
    @Binding var  isPresented: Bool
    @State var selected = 0
    @State var flag = false
    @State var selectedDate = Date()
    @State var holdingDate = Date()
    @State var feelingsArray = ["1","2","3","4","5"]
    @State var filteredFeelingsArray = ["1","2","3","4","5"]
    @State var tag:Int? = nil
    @State var editButton = false
    @State var addItem = ""
    @ObservedObject var entriesSettings = EntriesSettings()
    let languagePrefix = Bundle.main.preferredLocalizations.first?.prefix(2)

    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                    
                    Text("How are you?")
                        .font(.system(size: 25))
                        .foregroundColor(Color("Myblack"))
                        .padding(.top,35)

                    
                    HStack {
                        Image(systemName:"calendar")
                            .font(.title3)
                            .foregroundColor(Color("Myblue"))
                        Text(MoodCheckView.formatter.string(from: selectedDate))
                            .font(.system(size: 17))
                            .foregroundColor(Color("Myblue"))
                            .underline()
                            .onTapGesture{
                                
                                self.flag.toggle()
                            }
                    }
                    .padding(2)
                    
                    
                    // HStack has emoji
                    HStack{
                        ForEach (filteredFeelingsArray, id:\.self) {item in
                            EmojiMoodButton(colorName: item,circleSize: 50,fontSize: 11)
                                .onTapGesture {
                                    
                                    withAnimation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0)) {
                                        self.currentMoment = "\(item)"
                                        if filteredFeelingsArray.count == 1 {
                                            filteredFeelingsArray = feelingsArray
                                        } else {
                                            filteredFeelingsArray = filteredFeelingsArray.filter {$0 == "\(item)"}
                                        }
                                    }
                                    
                                }
                        }
                    }
                    
                    // Selection
                    VStack{
                        if self.currentMoment == "" {
                        } else {
                            
                            moodCheckingBar(selected: self.$selected)
                                .padding()
                            //.animation(Animation.easeIn.delay(0.3))
                                .shadow(radius: 5)
                            
                            
                            VStack {
                                
                                if self.selected == 0 {
                                    
                                    ScrollView(.vertical,showsIndicators: true) {
                                        LazyVGrid(columns: columns) {
                                            
                                            ForEach(entriesSettings.moodArray,id: \.self) { mood in
                                                
                                                // Make it in Main struct
                                                MultipleSelectionRow(text: mood.name, isSelected: currentMood.contains(mood.name)){
                                                    
                                                    if currentMood.contains(mood.name) {
                                                        currentMood.removeAll(where: { $0 == mood.name })
                                                    }
                                                    else {
                                                        currentMood.append(mood.name)
                                                    }
                                                    
                                                }
                                                
                                            }
                                            
                                        }.padding(10)
                                        
                                    }
                                    .onAppear {
                                        self.selected = 0
                                    }
                                    
                                    
                                    
                                }
                                
                                  else if self.selected == 1 {
                                  
                                  
                                  ScrollView(.vertical,showsIndicators: true) {
                                  LazyVGrid(columns: columns) {
                                  
                                  ForEach(entriesSettings.activityArray,id: \.self) { mood in
                                  
                                  // Make it in Main struct
                                  MultipleSelectionRow(text: mood.name, isSelected: currentActivity.contains(mood.name)){
                                  
                                  if currentActivity.contains(mood.name) {
                                  currentActivity.removeAll(where: { $0 == mood.name })
                                  }
                                  else {
                                  currentActivity.append(mood.name)
                                  }
                                  
                                  }
                                  
                                  }
                                  
                                  }.padding(10)
                                  
                                  
                                  }
                                  
                                  
                                  
                                  .onAppear() {
                                  self.selected = 1
                                  }
                                  
                                  
                                  } else if self.selected == 2 {
                                  
                                  
                                  ScrollView(.vertical,showsIndicators: true) {
                                  LazyVGrid(columns: columns) {
                                  
                                  ForEach(entriesSettings.peopleArray,id: \.self) { mood in
                                  
                                  // Make it in Main struct
                                  MultipleSelectionRow(text: mood.name, isSelected: peopleWith.contains(mood.name)){
                                  
                                  if peopleWith.contains(mood.name) {
                                  peopleWith.removeAll(where: { $0 == mood.name })
                                  }
                                  else {
                                  peopleWith.append(mood.name)
                                  }
                                  
                                  }
                                  
                                  }
                                  
                                  }.padding(10)
                                  
                                  
                                  }
                                  
                                  .onAppear() {
                                  self.selected = 2
                                  }
                                  
                                  } else if self.selected == 3 {
                                  
                                  
                                  ScrollView(.vertical,showsIndicators: true) {
                                  LazyVGrid(columns: columns) {
                                  
                                  ForEach(entriesSettings.placeArray,id: \.self) { mood in
                                  
                                  // Make it in Main struct
                                  MultipleSelectionRow(text: mood.name, isSelected: currentPlace.contains(mood.name)){
                                  
                                  if currentPlace.contains(mood.name) {
                                  currentPlace.removeAll(where: { $0 == mood.name })
                                  }
                                  else {
                                  currentPlace.append(mood.name)
                                  }
                                  }
                                  }
                                  }.padding(10)
                                  }
                                  .onAppear() {
                                  self.selected = 3
                                  }
                                  }
                                  
                                  
                            }
                            .frame(height: 225)
                            .background(Color("Myblue"))
                            .cornerRadius(20)
                            .shadow(radius: 5)
                            .padding(.horizontal,75)
                            
                            HStack {
                                
                                VStack{
                                    Image(systemName: "pencil.circle.fill")
                                        .foregroundColor(Color.red)
                                        .font(.system(size: 40))
                                    Text("Edit")
                                        .foregroundColor(Color("Myblack"))
                                        .font(.footnote)
                                        .bold()
                                }
                                .onTapGesture {
                                    self.editButton = true
                                }
                                
                                
                                switch selected {
                                case 0:
                                    nextButton(selectiveArray: currentMood,lastStep: false)
                                    
                                case 1:
                                    nextButton(selectiveArray: currentActivity,lastStep: false)
                                case 2:
                                    nextButton(selectiveArray: peopleWith,lastStep: false)
                                case 3:
                                    nextButton(selectiveArray: currentPlace,lastStep: true)
                                    
                                default:
                                    Text("Hi")
                                }
                            }
                            
                            
                            NavigationLink(destination: describeView(currentMoment: self.currentMoment, currentMood: self.currentMood, currentActivity: self.currentActivity, peopleWith: self.peopleWith, currentPlace: self.currentPlace,selectedDate:self.selectedDate ,isPresented: self.$isPresented), tag: 1, selection: $tag) {
                                EmptyView()
                            }
                            
                            
                        }
                        
                    }
                    .animation(.spring())
                    
                    Spacer()
                }
                
                
                
                if flag {
                    Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
                        .scaleEffect()
                        .onTapGesture {
                            self.flag.toggle()
                        }
                    VStack {
                        HStack {
                            Button(action: {
                                self.flag.toggle()
                            }) {
                                Text("Cancel")
                                    .font(.system(size: 17))
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
                                    .font(.system(size: 17))
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
                    
                    .frame(width:UIScreen.main.bounds.width,height: 300)
                    .background(Color.primary.colorInvert()).cornerRadius(50)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
                    .zIndex(0)
                }
                
                
                if editButton {
                    
                    if selected == 0 {
                        
                        editArray(selectedArray: entriesSettings.moodArray)
                        
                    }
                    
                    if selected == 1 {
                        
                         editArray(selectedArray: entriesSettings.activityArray)
                        
                    }
                    
                    
                    if selected == 2 {
                        
                          editArray(selectedArray: entriesSettings.peopleArray)
                        
                    }
                    
                    
                    if selected == 3 {
                        
                         editArray(selectedArray: entriesSettings.placeArray)
                        
                    }
                    
                    
                    
                }
                
                
                
            }
            .navigationBarTitle("Add Mode",displayMode: .inline)
            .edgesIgnoringSafeArea(.bottom)
            .multilineTextAlignment(.center)

        }
        .onAppear {
            print(selectedDate)
        }
        
        
    }
    
    
    
}

extension MoodCheckView {
    
    
    @ViewBuilder func nextButton(selectiveArray: [String],lastStep: Bool) -> some View {
        
        VStack{
            
            if languagePrefix == "ar" {
                Image(systemName: "chevron.left.circle.fill")
                    .foregroundColor(selectiveArray.isEmpty ? Color.gray : Color("Myblue"))
                    .font(.system(size: 40))
            } else {
                Image(systemName: "chevron.right.circle.fill")
                    .foregroundColor(selectiveArray.isEmpty ? Color.gray : Color("Myblue"))
                    .font(.system(size: 40))
            }
            Text(lastStep ? "Continue" : "Next")
                .foregroundColor(Color("Myblack"))
                .font(.footnote)
                .bold()
        }
        .onTapGesture {
            if selected < 3 {
                self.selected =  selected + 1
                
            }  else {
                tag = 1
            }
        }
        
    }
    
    
    
    @ViewBuilder func editArray(selectedArray: [MoodSelective]) -> some View {
        
        
        
        Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
            .scaleEffect()
            .onTapGesture {
                self.editButton.toggle()
            }
        
        VStack {
            HStack {
                
                EditButton()
                    .font(.system(size: 17))
                    .foregroundColor(Color.white)
                    .padding()
                    .padding(.horizontal,5)
                
                Spacer()
                
                Button(action: {
                    
                    switch selected {
                    case 0:
                        self.entriesSettings.moodArray.insert(MoodSelective(name: addItem), at: 0)
                        self.addItem = ""
                    case 1:
                        self.entriesSettings.activityArray.insert(MoodSelective(name: addItem), at: 0)
                        self.addItem = ""
                    case 2:
                        self.entriesSettings.peopleArray.insert(MoodSelective(name: addItem), at: 0)
                        self.addItem = ""
                    case 3:
                        self.entriesSettings.placeArray.insert(MoodSelective(name: addItem), at: 0)
                        self.addItem = ""
                    default:
                        print("Hi")
                    }
                    
                    
                }) {
                    
                    Image(systemName: "plus")
                        .font(.system(size: 17))
                        .foregroundColor(Color.white)
                    
                    
                }
                .padding()
                .padding(.horizontal,5)
                .disabled(self.addItem.isEmpty)
                
            }.background(Color("Myblue"))
            
            TextField("Add More", text: $addItem)
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal)
            
            Divider()
                .padding(.bottom)
            
            List() {
                
                ForEach(selectedArray,id:\.self) { item in
                    
                    Text("\(item.name)")
                    
                }
                .onDelete { IndexSet in
                    
                    switch selected {
                    case 0:
                        entriesSettings.deleteMood(at: IndexSet)
                    case 1:
                        entriesSettings.deleteActivity(at: IndexSet)
                    case 2:
                        entriesSettings.deletePeople(at: IndexSet)

                    case 3:
                        entriesSettings.deletePlace(at: IndexSet)

                        
                    default:
                        print("Hi")
                    }
                    
                    
                }
                
                
            }
           .listStyle(.inset)
            
            
            
            
            
        }.frame(width:UIScreen.main.bounds.width,height: 500)
            .background(Color.primary.colorInvert()).cornerRadius(50)
            .transition(.move(edge: .bottom))
            .animation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
            .zIndex(0)
            .onDisappear() {
                self.editButton = false
            }
        
        
    }
    
    
}


struct MoodCheckView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            MoodCheckView(isPresented: .constant(false))
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                .previewDisplayName("iPhone 12 Pro Max")
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

struct moodCheckingBar : View {
    
    @Binding var selected : Int
    
    
    var body : some View{
        
        
        HStack {
            
            // Mood
            Button(action: {
                self.selected = 0
            })
            {
                Text("Feelings")
                    .font(.system(size: 13))
                    .bold()
                    .minimumScaleFactor(0.7)
                    .lineLimit(0)
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
                    .font(.system(size: 15))
                    .bold()
                    .minimumScaleFactor(0.7)
                    .lineLimit(0)
                    .padding(.vertical,12)
                    .padding(.horizontal,13)
                //.allowsTightening(true)
                    .background(self.selected == 1 ?  Color("Mywhite") : Color.clear)
                    .clipShape(Capsule())
            }.foregroundColor(self.selected == 1 ? Color("Myblue") : Color("Mywhite"))
            
            Button(action: {
                self.selected = 2
            })
            {
                Text("With")
                    .font(.system(size: 13))
                    .bold()
                    .minimumScaleFactor(0.7)
                    .lineLimit(0)
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
                    .font(.system(size: 13))
                    .bold()
                    .minimumScaleFactor(0.7)
                    .lineLimit(0)
                    .padding(.vertical,10)
                    .padding(.horizontal,15)
                    .background(self.selected == 3 ?  Color("Mywhite") : Color.clear)
                    .clipShape(Capsule())
            }.foregroundColor(self.selected == 3 ? Color("Myblue") : Color("Mywhite"))
            
        }
        .padding(5)
        .background(Color("Myblue"))
        .cornerRadius(20)
        
        
    }
}

struct MultipleSelectionRow: View {
    @State var text : String
    var isSelected: Bool
    var action: () -> Void
    
    
    var body: some View {
        Button(action: self.action) {
            Text(text)
                .font(.system(size: 17))
                .minimumScaleFactor(0.8)
                .lineLimit(2)
                .padding(.all, 10.0)
                .contentShape(Rectangle())
                .foregroundColor(isSelected ? Color("Mywhite"): Color("Myblue"))
                .background(isSelected ? Color("Myblue"): Color("Mywhite"))
                .cornerRadius(20)
                .shadow(radius: 4)
        }
    }
}

// Customizing Emoji.
struct EmojiMoodButton: View {
    var colorName: String
    var textArray = [NSLocalizedString("", comment: "")
        ,NSLocalizedString("Awful", comment: ""),
                     NSLocalizedString("Meh", comment: ""),
                     NSLocalizedString("OK", comment: ""),
                     NSLocalizedString("Good", comment: ""),
                     NSLocalizedString("Great", comment: "")]
    
    //["","Awful","Meh","OK","Good","Great"]
    var circleSize: CGFloat
    var fontSize : CGFloat
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(Color(colorName))
                    .shadow(radius: 3)
                    .frame(width: circleSize, height: circleSize)
                
                Image(colorName)
                    .resizable()
                    .frame(width: circleSize - 5, height: circleSize - 5)
                    .scaledToFill()
            }
            Text(textArray[Int(colorName) ?? 0])
                .foregroundColor(Color("Myblack"))
                .font(.system(size: fontSize))
                .fontWeight(.bold)
            
        }
    }
}

