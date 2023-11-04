//
//  StatsView.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 5/22/21.
//

import Foundation
import SwiftUICharts
import SwiftUI
//import Charts



struct StatsView: View {
    
    
    @State var settings = ["Backup to iCloud","Privacy & Security"]
    @State var icons = ["icloud","hand.raised"]
    @State var selectedMood = ""
    @State var value = 0
    @State var pickerSelectedItem = 0
    @State var firstMood = false
    @State var secondMood = false
    @State var thirdMood = false
    @State var fourthMood = false
    @State var fifthMood = false
    @Namespace var namespace
 
    
    
    
     @FetchRequest(
         entity: Mood.entity(),
         sortDescriptors: [
             NSSortDescriptor(keyPath: \Mood.currentMoment, ascending: true),
         ],
         predicate: NSPredicate(format: "currentMoment == %@", "1")
     )   var counter1: FetchedResults<Mood>
     @FetchRequest(
         entity: Mood.entity(),
         sortDescriptors: [
             NSSortDescriptor(keyPath: \Mood.currentMoment, ascending: true),
         ],
         predicate: NSPredicate(format: "currentMoment == %@", "2")
     )   var counter2: FetchedResults<Mood>
     @FetchRequest(
         entity: Mood.entity(),
         sortDescriptors: [
             NSSortDescriptor(keyPath: \Mood.currentMoment, ascending: true),
         ],
         predicate: NSPredicate(format: "currentMoment == %@", "3")
     )   var counter3: FetchedResults<Mood>
     @FetchRequest(
         entity: Mood.entity(),
         sortDescriptors: [
             NSSortDescriptor(keyPath: \Mood.currentMoment, ascending: true),
         ],
         predicate: NSPredicate(format: "currentMoment == %@", "4")
     )   var counter4: FetchedResults<Mood>
     @FetchRequest(
         entity: Mood.entity(),
         sortDescriptors: [
             NSSortDescriptor(keyPath: \Mood.currentMoment, ascending: true),
         ],
         predicate: NSPredicate(format: "currentMoment == %@", "5")
     )   var counter5: FetchedResults<Mood>
    
    
    var chartData : [ChartCellModel] {
            get {
             //return "You got \(points) \(string2) "
                return [ ChartCellModel(color: Color("1"), value: CGFloat(counter1.count), name: "1"),
                         ChartCellModel(color: Color("2"), value: CGFloat(counter2.count), name: "2"),
                         ChartCellModel(color: Color("3"), value: CGFloat(counter3.count), name: "3"),
                         ChartCellModel(color: Color("4"), value: CGFloat(counter4.count), name: "4"),
                         ChartCellModel(color: Color("5"), value: CGFloat(counter5.count), name: "5")]
            }
        }

    
    
    @State var selectedPie: String = ""
    let chartStyle = ChartStyle(backgroundColor: Color.white,
                                accentColor: Color("Myblue"),
                                secondGradientColor: Color("Myblue"),
                                textColor: Color.black
                                , legendTextColor: Color.black,
                                dropShadowColor: Color.black.opacity(0.2)
    )
    
    
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: 20) {
                VStack(spacing:5) {
            
                    Text("Overall")
                        .foregroundColor(Color("Myblue"))
                }
     
                Spacer()
                
            }
            .font(.custom("Apercu-bold", size: 22))
            .padding(.horizontal,30)
            
            Divider()
                .padding(.top,5)
      
                HStack(spacing: 20) {
                    VStack {
                        PieChart(dataModel: ChartDataModel.init(dataModel: chartData), onTap: {
                            dataModel in
                            
                            if let dataModel = dataModel {
                                self.selectedPie = "Mood: \(dataModel.name)\n \(dataModel.value)"
                                self.value = Int(dataModel.value)
                                self.selectedMood = dataModel.name
                                if selectedMood == "1" {
                                    self.firstMood = true
                                    self.secondMood = false
                                    self.thirdMood = false
                                    self.fourthMood = false
                                    self.fifthMood = false
                                } else if selectedMood == "2" {
                                    self.firstMood = false
                                    self.secondMood = true
                                    self.thirdMood = false
                                    self.fourthMood = false
                                    self.fifthMood = false
                                } else if selectedMood == "3" {
                                    self.firstMood = false
                                    self.secondMood = false
                                    self.thirdMood = true
                                    self.fourthMood = false
                                    self.fifthMood = false
                                } else if selectedMood == "4" {
                                    self.firstMood = false
                                    self.secondMood = false
                                    self.thirdMood = false
                                    self.fourthMood = true
                                    self.fifthMood = false
                                } else if selectedMood == "5" {
                                    self.firstMood = false
                                    self.secondMood = false
                                    self.thirdMood = false
                                    self.fourthMood = false
                                    self.fifthMood = true
                                }
                                
                            } else {
                                self.selectedPie = ""
                                self.firstMood = false
                                self.secondMood = false
                                self.thirdMood = false
                                self.fourthMood = false
                                self.fifthMood = false
                            }
                            
                        }).frame(width: 250, height: 250, alignment: .center)
                        .shadow(radius: 4)
                        .padding()
                        .animation(.spring())
                       
                    }
                    
                    VStack(spacing:1){
                    
                        
                        VStack {
                            Text("Great").font(.footnote)
                            HStack {
                                if fifthMood {
                                    Circle()
                                        .foregroundColor(Color("5"))
                                        .matchedGeometryEffect(id: "first", in: namespace)
                                        .frame(width: 30, height: 30, alignment: .center)
                                    
                                } else {
                                    Circle()
                                        .foregroundColor(Color("5"))
                                        .matchedGeometryEffect(id: "first", in: namespace)
                                        .frame(width: 15, height: 15, alignment: .center)
                                }
                                
                                Text("\(counter5.count)")
                              
                            }
                        }
                        Divider()
                        VStack {
                            Text("Good").font(.footnote)
                            HStack {
                                if fourthMood {
                                    Circle()
                                        .foregroundColor(Color("4"))
                                        .matchedGeometryEffect(id: "second", in: namespace)
                                        .frame(width: 30, height: 30, alignment: .center)
                                } else {
                                    Circle()
                                        .foregroundColor(Color("4"))
                                        .matchedGeometryEffect(id: "second", in: namespace)
                                        .frame(width: 15, height: 15, alignment: .center)
                                }
                            //    Text("\(counter4.count)")
                            }
                        }
                        Divider()

                        VStack {
                            Text("Ok").font(.footnote)
                            HStack {
                                if thirdMood {
                                    Circle()
                                        .foregroundColor(Color("3"))
                                        .matchedGeometryEffect(id: "third", in: namespace)
                                        .frame(width: 30, height: 30, alignment: .center)
                                } else {
                                    Circle()
                                        .foregroundColor(Color("3"))
                                        .matchedGeometryEffect(id: "third", in: namespace)
                                        .frame(width: 15, height: 15, alignment: .center)
                                }
                               // Text("\(counter3.count)")
                            }
                        }
                        Divider()

                        VStack {
                            Text("Meh").font(.footnote)
                            HStack {
                                if secondMood {
                                    Circle()
                                        .foregroundColor(Color("2"))
                                        .matchedGeometryEffect(id: "fourth", in: namespace)
                                        .frame(width: 30, height: 30, alignment: .center)
                                } else {
                                    Circle()
                                        .foregroundColor(Color("2"))
                                        .matchedGeometryEffect(id: "fourth", in: namespace)
                                        .frame(width: 15, height: 15, alignment: .center)
                                }
                             //   Text("\(counter2.count)")
                            }
                        }
                        Divider()

                        VStack {
                            Text("Terriable").font(.footnote)
                            HStack {
                                if firstMood {
                                        Circle()
                                                .foregroundColor(Color("1"))
                                                .matchedGeometryEffect(id: "fifth", in: namespace)
                                                .frame(width: 30, height: 30, alignment: .center)
                                    
                                } else {
                                    Circle()
                                        .foregroundColor(Color("1"))
                                        .matchedGeometryEffect(id: "fifth", in: namespace)
                                        .frame(width: 15, height: 15, alignment: .center)
                                }
                             //   Text("\(counter1.count)")
                            }
                        }

                    }

                    Spacer()
                    
                }
                .padding(.top)
            
            VStack {
                HStack {
                    Text("About the graph")
                        .bold()
                    Spacer()
                }.padding(.horizontal)
                
                VStack{
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.")
                        .padding()
                }
            
                .frame(width: 350, height: 300, alignment: .topLeading)
                .background(Color.white)
                .cornerRadius(20)
                .clipped()
                .shadow(radius: 5)

                
                
            }
                
            Spacer()
            
        }
        .onAppear() {
            
        }
      
        
    }
    
    func counting() {
        
        
    }
    
}


struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}


// Customizing Emoji.
struct EmojiMoodButton2: View {
    var colorName: String
    var moodCounter: Int
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(Color(colorName))
                    .shadow(radius: 3)
                    .frame(width: 30, height: 30)
                
                Image(colorName)
                    .resizable()
                    .frame(width: 35, height: 35)
                    .scaledToFill()
            }
            Text("\(moodCounter)")
        }
    }
}
