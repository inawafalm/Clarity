//
//  MyMoodList.swift
//  life
//
//  Created by Nawaf Almutairi on 2/2/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI
import Combine

struct moodStructure: Identifiable,Codable {
    
    let id = UUID()
    let currentMood: String
    let currentActivity: String
    let peopleWith: String
    let currentPlace: String
    let whatHappenText: String
    let currentMoment: String
}

class MoodViewModel: ObservableObject {
    @Published var moodArray:  [moodStructure] =  [.init(currentMood: "Calm", currentActivity: "Coding", peopleWith: "Friends", currentPlace: "Home", whatHappenText: "Nothing.", currentMoment: "5"),.init(currentMood: "Calm", currentActivity: "Coding,Coding,", peopleWith: "Alone", currentPlace: "Home", whatHappenText: "Nothing.", currentMoment: "4"),
       .init(currentMood: "Calm", currentActivity: "Coding,Coding,", peopleWith: "Alone", currentPlace: "Home", whatHappenText: "Nothing.", currentMoment: "3"),
       .init(currentMood: "Calm", currentActivity: "Coding,Coding,", peopleWith: "Alone", currentPlace: "Home", whatHappenText: "Nothing.", currentMoment: "2"),
       .init(currentMood: "Calm", currentActivity: "Coding,Coding,", peopleWith: "Alone", currentPlace: "Home", whatHappenText: "Nothing.", currentMoment: "1")]
       
    
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
     }*/
    
}


struct MyMoodList: View {
    
    
    let currentMood: String
    let currentActivity: String
    let peopleWith: String
    let currentPlace: String
    let whatHappenText: String
    let currentMoment: String
    @ObservedObject var moodVM = MoodViewModel()
    @State var isPresentingAddMood = false
    
    var colorArray = [Color.red,Color.orange,Color.yellow,Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)),Color(#colorLiteral(red: 0.004859850742, green: 0.09608627111, blue: 0.5749928951, alpha: 0.7034728168))]
    
    var body: some View {
        
        ZStack {
            NavigationView {
                List {
                    ForEach(moodVM.moodArray) { item in
                        NavigationLink(destination:MoodDetail(moodDetail: item)){
                            VStack() {
                                Image(item.currentMoment)
                                    .resizable()
                                   // .renderingMode(.template)
                                .frame(width: 100, height: 100)
                                .scaledToFill()
                                .clipShape(Circle())
                               // .foregroundColor(Color.red)
                                
                                
                            }
                            VStack(alignment: .leading) {
                                HStack {
                                    VStack {
                                        Text(item.currentMood)
                                            .foregroundColor(Color.init(UIColor(red: 0.90, green: 0.92, blue: 0.91, alpha: 1.00)))
                                            .font(.title)
                                            .fontWeight(.semibold)
                                            .padding()
                                        HStack(){
                                            Text(item.currentActivity)
                                                .textChoiceStyleCellModifier(with: item.currentMoment)
                                            Text(item.peopleWith)
                                            .textChoiceStyleCellModifier(with: item.currentMoment)
                                            Text(item.currentPlace)
                                            .textChoiceStyleCellModifier(with: item.currentMoment)
                                        }
                                        .foregroundColor(Color.init(UIColor(red: 0.90, green: 0.92, blue: 0.91, alpha: 1.00)))
                                        .font(.callout)
                                    }
                                }
                                VStack{
                                    Text("Monday, APR 26")
                                    .foregroundColor((Color.init(UIColor(red: 0.06, green: 0.11, blue: 0.11, alpha: 1.00))))
                                        .font(.footnote)
                                }
                                .padding(.top, 10.0)
                            }
                            .padding()
                            
                        }
                        .padding()
                        .frame(height: 175)
                        .background(LinearGradient(gradient: .init(colors:
                                       [.init(red:0.11, green:0.50, blue:0.49),
                                        .init(red:0.12, green:0.60, blue:0.56)]),
                                        startPoint: .top, endPoint: .bottom))
                        .cornerRadius(10)
                        .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        
                    }
                    .onDelete(perform: removeItems)
                    .listRowBackground(Color.init(UIColor(red: 0.90, green: 0.92, blue: 0.91, alpha: 1.00)))
                }.onAppear {
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().separatorColor = UIColor(red: 0.90, green: 0.92, blue: 0.91, alpha: 1.00)
                    UITableView.appearance().backgroundColor = UIColor(red: 0.90, green: 0.92, blue: 0.91, alpha: 1.00)
                   // UINavigationBar.appearance().backgroundColor = UIColor(ciColor: .init(red:0.11, green:0.50, blue:0.49))
                }
                .navigationBarTitle("Tracker")
                .listStyle(GroupedListStyle())
                .navigationBarItems(trailing: Button(action: {
                    self.isPresentingAddMood.toggle()
                }) {
                    Image(systemName: "plus")
                })
                
            }
            .navigationBarColor(.black)
            .sheet(isPresented: $isPresentingAddMood){
                MoodCheckView(moodVM: self.moodVM, currentMood: self.currentMood, currentActivity:self.currentActivity, peopleWith: self.peopleWith,
                              currentPlace: self.currentPlace, currentMoment: self.currentMoment, isPresented: self.$isPresentingAddMood)
            }
        }
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
