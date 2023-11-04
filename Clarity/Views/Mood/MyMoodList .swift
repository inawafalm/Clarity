//
//  MyMoodList.swift
//  life
//
//  Created by Nawaf Almutairi on 2/2/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//
import SwiftUI
import Combine


struct MyMoodList: View {
    
    
    let today = Date().removeTimeStamp
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date().removeTimeStamp!)
    let older = Calendar.current.date(byAdding: .day, value: -7, to: Date().removeTimeStamp!)
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(entity: Mood.entity(), sortDescriptors: [NSSortDescriptor(key: "decodedDate", ascending: false)])
    var moods: FetchedResults<Mood>
    
    @FetchRequest(entity: ThoughtRecord.entity(), sortDescriptors: [NSSortDescriptor(key: "decodedDate", ascending: false)])
    var thoughts: FetchedResults<ThoughtRecord>
    
    
    
    @State var isPresentingAddMood = false
    @State var isPresentingMyMood = false
    @State var selectedExersice = true
    @State var selectedMood: moodStructure? = nil
    
    @State var selectedThought: ThoughtStructure? = nil
    @State var isPresentingAddThought = false
    @State var isPresentingMyThought = false
    @Namespace var name
    @AppStorage("onboarding") var onboarding = true
    
    
    var body: some View {
        
        
        //NavigationView {
        ZStack {
            VStack(alignment: .center) {
                
                // Top  "Tracker"
                HStack(spacing:10) {
                    
                    
                    VStack(spacing:5) {
                        
                        Text(LocalizedStringKey("Mood Tracker"))
                            .foregroundColor(Color("Myblue"))
                            .font(.footnote)
                            .fontWeight(.bold)
                            .opacity(selectedExersice ? 1.0 : 0.65)
                            .onTapGesture {
                                withAnimation(.spring()){selectedExersice.toggle()}
                            }
                        if selectedExersice{
                            Circle().frame(width: 5, height: 5)
                                .foregroundColor(Color("Myblue"))
                                .matchedGeometryEffect(id: "L", in: name)
                        }
                        else {
                            Circle().frame(width: 5, height: 5)
                                .foregroundColor(.white)
                        }
                    }
                    
                    VStack(spacing:5) {
                        Text("Thought Record")
                            .font(.footnote)
                            .fontWeight(.bold)
                            .foregroundColor(Color("Myblue"))
                            .opacity(selectedExersice ? 0.65 : 1.0)
                            .onTapGesture {
                                withAnimation(.spring()){selectedExersice.toggle()}
                            }
                        if selectedExersice == false {
                            Circle().frame(width: 5, height: 5)
                                .foregroundColor(Color("Myblue"))
                                .matchedGeometryEffect(id: "L", in: name)
                        } else {
                            Circle().frame(width: 5, height: 5)
                                .foregroundColor(.white)
                        }
                        
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        
                        if selectedExersice == true {
                            self.isPresentingAddMood.toggle()
                            
                        } else {
                            self.isPresentingAddThought.toggle()
                            
                        }
                    }) {
                        ZStack {
                            Image(systemName: "plus")
                                .foregroundColor(Color("Myblue"))
                                .font(.system(size: 17))
                        }
                    }
                    
                }
                .font(.system(size: 22))
                .padding(.horizontal,30)
                .padding(.top,15)
                
                Divider()
                    .padding(.top,5)
                
                // Mood Tracker
                if selectedExersice == true {
                    
                    // IF COREDATA IS EMPTY
                    if moods.isEmpty {
                        //Spacer()
                        Text("Your Mood Tracker is Empty")
                            .font(.system(size: 18))
                            .bold()
                            .padding(.top,50)
                            .animation(.spring())
                        
                        Spacer()
                        
                        
                    } else {
                        
                        
                        List() {
                            
                            // TODAY LIST
                            
                            if let moodFilter = moods.filter{$0.decodedDate?.removeTimeStamp == today} {
                                
                                if moodFilter.isEmpty {
                                    
                                    
                                } else {
                                    /*
                                    Section(header: Text("Today")
                                        .foregroundColor(Color("Myblue"))
                                        .font(.system(size: 28))
                                        .fontWeight(.bold)
                                        .opacity(0.5))
                                    {
                                        
                                        ForEach (moods.filter{$0.decodedDate?.removeTimeStamp == today}, id:\.self) { mood in
                                            
                                            
                                            MoodCard(currentMood: dataToStringArray(data: mood.currentMood!) ?? [""],
                                                     currentActivity: dataToStringArray(data: mood.currentActivity!) ?? [""],
                                                     peopleWith: dataToStringArray(data: mood.peopleWith!) ?? [""],
                                                     currentPlace: dataToStringArray(data: mood.currentPlace!) ?? [""],
                                                     whatHappenText: mood.journaling ?? "",
                                                     currentMoment: mood.currentMoment ?? "",
                                                     decodedDate: mood.decodedDate!,
                                                     selectedDate: mood.selectedDate ?? "",
                                                     time: mood.time ?? "",
                                                     year: mood.year ?? "",
                                                     month: mood.month ?? "",
                                                     day: mood.day ?? "")
                                            
                                            .onTapGesture{
                                                self.selectedMood = moodStructure(currentMood: dataToStringArray(data: mood.currentMood!) ?? [""],
                                                                                  currentActivity: dataToStringArray(data: mood.currentActivity!) ?? [""],
                                                                                  peopleWith: dataToStringArray(data: mood.peopleWith!) ?? [""],
                                                                                  currentPlace: dataToStringArray(data: mood.currentPlace!) ?? [""],
                                                                                  journaling: mood.journaling ?? "",
                                                                                  currentMoment: mood.currentMoment ?? "",
                                                                                  decodedDate: mood.decodedDate!,
                                                                                  selectedDate: mood.selectedDate ?? "",
                                                                                  time: mood.time ?? "",
                                                                                  year: mood.year ?? "",
                                                                                  month: mood.month ?? "",
                                                                                  day: mood.day ?? "")
                                                self.isPresentingMyMood.toggle()
                                            }
                                            
                                            
                                        }
                                        .onDelete(perform: deleteMood)
                                    }
                                    .accentColor(Color("Myblue"))
                                    
                                    */
                                    todaySection
                                    
                                    
                                }
                                
                            }
                            
                            // 7 Days
                        
                            if let moodFilter = moods.filter{($0.decodedDate?.removeTimeStamp)! <= yesterday! && ($0.decodedDate?.removeTimeStamp)! >= older!} {
                                
                                if moodFilter.isEmpty {
                                    
                                    
                                } else {
                                    
                                    lastSevenDaysSection
                                    
                                }
                                
                                
                                
                                
                            }
                            
                            
                            // OLDER LIST
                            if let moodFilter = moods.filter{($0.decodedDate?.removeTimeStamp)! < older!} {
                                
                                if moodFilter.isEmpty {
                                    
                                    
                                } else {
                                    
                                    olderSection
                                    
                                }
                                
                                
                            }
                            
                            
                            
                        }
                    }
                    
                } else {
                    // Thought Record
                    
                    if thoughts.isEmpty {
                        Text("Your Thought Record is Empty")
                            .font(.system(size: 18))
                            .bold()
                            .padding(.top,50)
                            .animation(.spring())
                    } else {
                        
                        List() {
                            ForEach(thoughts,id:\.self) { thought in
                                ThoughtRecordCard(trigger: thought.trigger ?? "", autoThought: thought.autoThought ?? "", emotions: thought.emotion ?? "", EFT: thought.eft ?? "", EAT: thought.eat ?? "" , alterThought: thought.alterThought ?? "", outcome: thought.outcome ?? "", time: thought.time ?? "", year: thought.year ?? "", month: thought.month ?? "", day: thought.day ?? "", selectedDate: thought.selectedDate ?? "", decodedDate: thought.decodedDate)
                                    .onTapGesture() {
                                        
                                        self.selectedThought = ThoughtStructure(trigger: thought.trigger ?? "", autoThought: thought.autoThought ?? "",
                                                                                emotions: thought.emotion ?? "", EFT: thought.eft ?? "", EAT: thought.eat ?? ""
                                                                                ,alterThought: thought.alterThought ?? "", outcome: thought.outcome ?? ""
                                                                                ,decodedDate: thought.decodedDate, selectedDate: thought.selectedDate ?? "",
                                                                                time: thought.time ?? "", year: thought.year ?? "",month: thought.month ?? "", day: thought.day ?? "")
                                        
                                        self.isPresentingMyThought = true
                                        
                                    }
                                
                                
                            }
                            .onDelete(perform: deleteThought)
                        }
                        
                    }
                    Spacer()
                    
                    
                }
                
            }
            .listStyle(.plain)
            .background(Color.clear)
            
            .onAppear {
               // UITableView.appearance().backgroundColor = UIColor.clear
                UITabBar.appearance().barTintColor = UIColor(named: "Myblue")
                UITabBar.appearance().tintColor = .white
                UITabBar.appearance().unselectedItemTintColor =  UIColor(.white.opacity(0.5))
            }
            
            .background(EmptyView()).fullScreenCover(item: self.$selectedMood, onDismiss: {
                self.isPresentingMyMood = false
            }, content: { mood in
                MoodDetail(moodDetail: mood, isPresented: $isPresentingMyMood)
                
            })
            
            .background(EmptyView()).fullScreenCover(item: self.$selectedThought, onDismiss: {
                self.isPresentingMyThought = false
            }, content: { thought in
                ThoughtDetail(thoughtDetail: thought, isPresented: $isPresentingMyThought)
                
            })
            
            //  MoodCheckView
            .background(EmptyView().sheet(isPresented: $isPresentingAddMood, onDismiss: {
                self.isPresentingAddMood = false
            }, content: {
                MoodCheckView(isPresented: self.$isPresentingAddMood)
                
            }))
            
            .background(EmptyView().sheet(isPresented: $isPresentingAddThought, onDismiss: {
                self.isPresentingAddThought = false
            }, content: {
                MainDiary(isPresented: $isPresentingAddThought)
            }))
            
        }
        .multilineTextAlignment(.center)
        
        
    }
    
}



extension MyMoodList {
    private func saveContext() {
        do {
            try viewContext.save()
            
        } catch  {
            let error = error as NSError
            fatalError("Opsy: \(error)")
        }
    }
    
    
    func deleteMood(at offsets: IndexSet) {
        
        
        withAnimation(.default) {
            
            
            offsets.map {moods[$0]}.forEach(viewContext.delete)
            
            for offset in offsets {
                
                let mood = moods[offset]
                viewContext.delete(mood)
                
            }
            
            saveContext()
            
        }
        
        
        
        
        
    }
    
    func deleteThought(at offsets: IndexSet) {
        
        
        withAnimation(.default) {
            
            
            offsets.map {thoughts[$0]}.forEach(viewContext.delete)
            
            for offset in offsets {
                
                let mood = thoughts[offset]
                viewContext.delete(mood)
                
            }
            
            saveContext()
            
        }
        
        
        
        
        
    }
    
    private var todaySection: some View {
        Section(header: Text("Today")
            .foregroundColor(Color("Myblue"))
            .font(.system(size: 28))
            .fontWeight(.bold)
            .opacity(0.5)) {
                ForEach(moods.filter { $0.decodedDate?.removeTimeStamp == today }, id: \.self) { mood in
                    MoodCard(currentMood: dataToStringArray(data: mood.currentMood!) ?? [""],
                             currentActivity: dataToStringArray(data: mood.currentActivity!) ?? [""],
                             peopleWith: dataToStringArray(data: mood.peopleWith!) ?? [""],
                             currentPlace: dataToStringArray(data: mood.currentPlace!) ?? [""],
                             whatHappenText: mood.journaling ?? "",
                             currentMoment: mood.currentMoment ?? "",
                             decodedDate: mood.decodedDate!,
                             selectedDate: mood.selectedDate ?? "",
                             time: mood.time ?? "",
                             year: mood.year ?? "",
                             month: mood.month ?? "",
                             day: mood.day ?? "")
                    .onTapGesture {
                        self.selectedMood = moodStructure(currentMood: dataToStringArray(data: mood.currentMood!) ?? [""],
                                                          currentActivity: dataToStringArray(data: mood.currentActivity!) ?? [""],
                                                          peopleWith: dataToStringArray(data: mood.peopleWith!) ?? [""],
                                                          currentPlace: dataToStringArray(data: mood.currentPlace!) ?? [""],
                                                          journaling: mood.journaling ?? "",
                                                          currentMoment: mood.currentMoment ?? "",
                                                          decodedDate: mood.decodedDate!,
                                                          selectedDate: mood.selectedDate ?? "",
                                                          time: mood.time ?? "",
                                                          year: mood.year ?? "",
                                                          month: mood.month ?? "",
                                                          day: mood.day ?? "")
                        self.isPresentingMyMood.toggle()
                    }
                }
                .onDelete(perform: deleteMood)
            }
            .accentColor(Color("Myblue"))
    }
    
    private var lastSevenDaysSection: some View {
        
        Section(header: Text("Last 7 days")
            .foregroundColor(Color("Myblue"))
            .font(.system(size: 28))
            .fontWeight(.bold)
            .opacity(0.5))
        {
            
            ForEach(moods.filter{($0.decodedDate?.removeTimeStamp)! <= yesterday! && ($0.decodedDate?.removeTimeStamp)! >= older!}, id:\.self) { mood in
                MoodCard(currentMood: dataToStringArray(data: mood.currentMood!) ?? [""],
                         currentActivity: dataToStringArray(data: mood.currentActivity!) ?? [""],
                         peopleWith: dataToStringArray(data: mood.peopleWith!) ?? [""],
                         currentPlace: dataToStringArray(data: mood.currentPlace!) ?? [""],
                         whatHappenText: mood.journaling ?? "",
                         currentMoment: mood.currentMoment ?? "",
                         decodedDate: mood.decodedDate!,
                         selectedDate: mood.selectedDate ?? "",
                         time: mood.time ?? "",
                         year: mood.year ?? "",
                         month: mood.month ?? "",
                         day: mood.day ?? "")
                .onTapGesture{
                    self.selectedMood = moodStructure(currentMood: dataToStringArray(data: mood.currentMood!) ?? [""],
                                                      currentActivity: dataToStringArray(data: mood.currentActivity!) ?? [""],
                                                      peopleWith: dataToStringArray(data: mood.peopleWith!) ?? [""],
                                                      currentPlace: dataToStringArray(data: mood.currentPlace!) ?? [""],
                                                      journaling: mood.journaling ?? "",
                                                      currentMoment: mood.currentMoment ?? "",
                                                      decodedDate: mood.decodedDate!,
                                                      selectedDate: mood.selectedDate ?? "",
                                                      time: mood.time ?? "",
                                                      year: mood.year ?? "",
                                                      month: mood.month ?? "",
                                                      day: mood.day ?? "")
                    self.isPresentingMyMood.toggle()
                }
                
                
            }
            .onDelete(perform: deleteMood)
            
            
            
        }.accentColor(Color("Myblue"))
        
    }
    
    private var olderSection: some View {
        
        Section(header: Text("Older")
            .foregroundColor(Color("Myblue"))
            .font(.system(size: 28))
            .fontWeight(.bold)
            .opacity(0.5))
        {
            
            ForEach(moods.filter{($0.decodedDate?.removeTimeStamp)! < older!}, id:\.self) { mood in
                
                
                MoodCard(currentMood: dataToStringArray(data: mood.currentMood!) ?? [""],
                         currentActivity: dataToStringArray(data: mood.currentActivity!) ?? [""],
                         peopleWith: dataToStringArray(data: mood.peopleWith!) ?? [""],
                         currentPlace: dataToStringArray(data: mood.currentPlace!) ?? [""],
                         whatHappenText: mood.journaling ?? "",
                         currentMoment: mood.currentMoment ?? "",
                         decodedDate: mood.decodedDate!,
                         selectedDate: mood.selectedDate ?? "",
                         time: mood.time ?? "",
                         year: mood.year ?? "",
                         month: mood.month ?? "",
                         day: mood.day ?? "")
                .onTapGesture{
                    self.selectedMood = moodStructure(currentMood: dataToStringArray(data: mood.currentMood!) ?? [""],
                                                      currentActivity: dataToStringArray(data: mood.currentActivity!) ?? [""],
                                                      peopleWith: dataToStringArray(data: mood.peopleWith!) ?? [""],
                                                      currentPlace: dataToStringArray(data: mood.currentPlace!) ?? [""],
                                                      journaling: mood.journaling ?? "",
                                                      currentMoment: mood.currentMoment ?? "",
                                                      decodedDate: mood.decodedDate!,
                                                      selectedDate: mood.selectedDate ?? "",
                                                      time: mood.time ?? "",
                                                      year: mood.year ?? "",
                                                      month: mood.month ?? "",
                                                      day: mood.day ?? "")
                    self.isPresentingMyMood.toggle()
                }
                
                
            }
            .onDelete(perform: deleteMood)
            
            
        }.accentColor(Color("Myblue"))
        
        
    }
    
    // Your other methods, like deleteMood and dataToStringArray, go here
}



struct MyMoodList_Previews: PreviewProvider {
    static var previews: some View {
        MyMoodList().preferredColorScheme(.light)
        MoodCard(currentMood: ["a"], currentActivity: ["a"], peopleWith: ["a"], currentPlace: ["aa"], whatHappenText: "aaa", currentMoment: "1", decodedDate: Date(), selectedDate: "", time: "", year: "", month: "Nov", day: "")
        // Onboarding(onboarding: .constant(false))
        // MoodCard(currentMood: [""], currentActivity: [""], peopleWith: [""], currentPlace: [""], whatHappenText: "", currentMoment: "2", decodedDate: Date(), selectedDate: "", time: "", year: "", month: "", day: "")
        //        ThoughtRecordCard(trigger: "Hidasdsa fasodkasp asdioasdjisadiojas", autoThought: "", emotions: "", EFT: "", EAT: "", alterThought: "", outcome: "", selectedDate: "11/18/2021", decodedDate: Date())
        ThoughtRecordCard(trigger: "I was at the coffee shop and saw.", autoThought: "", emotions: "", EFT: "", EAT: "", alterThought: "", outcome: "", time: "", year: "", month: "Nov", day: "18", selectedDate: "asdasd", decodedDate: Date())
        
    }
}

