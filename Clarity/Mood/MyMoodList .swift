//
//  MyMoodList.swift
//  life
//
//  Created by Nawaf Almutairi on 2/2/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//
import SwiftUI
import Combine


struct moodStructure: Identifiable {
    
    var id = UUID()
    let currentMood: String
    let currentActivity: String
    let peopleWith: String
    let currentPlace: String
    let whatHappenText: String
    let currentMoment: String
}

//var myMoodArray : [moodStructure] = [moodStructure(currentMood: "Calm", currentActivity: "Coding", peopleWith: "Friends", currentPlace: "Home", whatHappenText: "Hi", currentMoment: "5")]

class MoodViewModel: ObservableObject {
    @Published var moodArray:  [moodStructure] = [
        .init(currentMood: "Calm", currentActivity: "Coding", peopleWith: "Friends", currentPlace: "Home", whatHappenText: "Nothing.", currentMoment: "3")
        ,
        .init(currentMood: "Calm", currentActivity: "Coding", peopleWith: "Friends", currentPlace: "Home", whatHappenText: "Nothing.", currentMoment: "4"),
        .init(currentMood: "Calm", currentActivity: "Coding", peopleWith: "Friends", currentPlace: "Home", whatHappenText: "Nothing.", currentMoment: "3"),
        .init(currentMood: "Calm", currentActivity: "Coding", peopleWith: "Friends", currentPlace: "Home", whatHappenText: "Nothing.", currentMoment: "2"),
        .init(currentMood: "Calm", currentActivity: "Coding", peopleWith: "Friends", currentPlace: "Home", whatHappenText: "Nothing.", currentMoment: "1")]
    
    /*
     {
     didSet {
     let encoder = JSONEncoder()
     if let encoded = try?
     encoder.encode(moodArray){
     UserDefaults.standard.set(encoded,forKey:"moodArray")
     }
     }
     }
     init() {
     if let moodArray =
     UserDefaults.standard.data(forKey: "moodArray")
     {
     let decoder = JSONDecoder()
     if let decoded = try?
     decoder.decode([moodStructure].self, from: moodArray)
     {
     self.moodArray = decoded
     return
     }
     }
     self.moodArray = []
     }
     */
    
}



struct MyMoodList: View {
    
    let currentMood: String
    let currentActivity: String
    let peopleWith: String
    let currentPlace: String
    let whatHappenText: String
    let currentMoment: String
    let currentColor = ""
    
    
    @ObservedObject var moodVM = MoodViewModel()
    @State var isPresentingAddMood = false
    @State var isPresentingMyMood = false
    @State var selectedMood: moodStructure? = nil
        
    var body: some View {

        NavigationView {
            HStack {
                List {
                    ForEach(moodVM.moodArray) { item in
                            
                            ZStack {
                                // Rectangle
                                RoundedRectangle(cornerRadius: 10.0)
                                    .foregroundColor(.white)
                                    .frame(height: 145)
                                    .shadow(radius: 5)
                                
                                // Content
                                HStack {
                                    
                                    // Date
                                    VStack {
                                        Text("26")
                                            .font(.title)
                                        Text("Sep")
                                        Divider()
                                            .frame(width:30)
                                        Text("10:00PM")
                                            .font(.footnote)
                                            .fontWeight(.semibold)
                                    }
                                    .padding(.top)
                                    Divider()
                                    
                                    
                                    VStack{
                                        HStack{
                                            //face
                                            ZStack {
                                                Circle()
                                                    .foregroundColor(Color(item.currentMoment))
                                                    .shadow(radius: 3)
                                                    .frame(width: 50, height: 50)
                                                
                                                
                                                Image(item.currentMoment)
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .scaledToFill()
                                            }
                                            
                                            // Mood Text
                                            Text(item.currentMood)
                                                .foregroundColor(Color(item.currentMoment))
                                                .font(.title)
                                                .fontWeight(.semibold)
                                            Spacer()
                                            
                                        }
                                        
                                        
                                        // Things
                                        HStack{
                                            Text(item.currentActivity)
                                            
                                            Divider().frame(height: 30)
                                            Text(item.peopleWith)
                                            
                                            Divider().frame(height: 30)
                                            Text(item.currentPlace)
                                            
                                            Spacer()
                                        }
                                        
                                    }
                                    
                                }.padding(.horizontal)
                               
                            }
                            
                            .onTapGesture{
                                self.selectedMood = item
                                self.isPresentingMyMood.toggle()
                            }
                                            
                        .frame(height: 130)
                        .padding()
                        .listRowInsets(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                            
                    }
                    
                    .onDelete(perform: removeItems)
                    
                }
                .onAppear {
                    UITableView.appearance().separatorColor = .clear
                    UITableView.appearance().backgroundColor = UIColor.clear
                    
                }
                .listStyle(PlainListStyle())
                
            }
            
            .navigationBarTitle("Tracker",displayMode: .large)
            .listStyle(GroupedListStyle())
            .navigationBarHidden(false)
            .navigationBarItems(trailing: Button(action: {
                self.isPresentingAddMood.toggle()
            }) {
                Image(systemName: "plus")
            })
            
        }
        
        
        .background(EmptyView().fullScreenCover(item: self.$selectedMood) { mood in
           // SwiftUITest2(isPresented: $show, text: mood.name)
            MoodDetail(moodDetail: mood, isPresented: self.$isPresentingMyMood)
        })
        
        
        .background(EmptyView().fullScreenCover(item: self.$selectedMood) {
            self.isPresentingMyMood = false
        } content: { mood in
            MoodDetail(moodDetail: mood, isPresented: self.$isPresentingMyMood)
        })

       //  MoodCheckView
        .background(EmptyView().sheet(isPresented: $isPresentingAddMood, onDismiss: {
            self.isPresentingAddMood = false
        }, content: {
            MoodCheckView(moodVM: self.moodVM, isPresented: self.$isPresentingAddMood)

        }))
        
        
    }
    func removeItems(at offsets: IndexSet) {
        moodVM.moodArray.remove(atOffsets: offsets)
    }
}


struct MyMoodList_Previews: PreviewProvider {
    static var previews: some View {
        MyMoodList(currentMood: "", currentActivity: "", peopleWith: "", currentPlace: "", whatHappenText: "", currentMoment: "")
    }
}
