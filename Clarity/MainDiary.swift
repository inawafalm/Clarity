//
//  MainDiary.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 08/11/2021.
//

import Foundation
import SwiftUI


//struct DiaryInput: Identifiable,Codable,Hashable {
//
//    var id = UUID()
//    var trigger: String
//    var autoThought : String
//    var emotions : String
//    var EFT : String
//    var EAT : String
//    var alterThought : String
//    var outcome : String
//
//}





struct MainDiary: View {
    
    @State var selectedPage = 0
    @State var trigger : String = ""
    @State var autoThought : String = ""
    @State var emotions : String = ""
    @State var EFT : String = ""
    @State var EAT : String = ""
    @State var alterThought : String = ""
    @State var outcome : String = ""
    
    @Binding var  isPresented: Bool
    
    @State var selectedDate = Date()
    @State var holdingDate = Date()
    @State var flag = false
    @State var flag2 = false
    
    @Environment(\.managedObjectContext) var viewContext
    
//    var formTitle = [NSLocalizedString("Situation / Trigger", comment: ""),
//                     NSLocalizedString("Automatic Thoughts", comment: ""),
//                     NSLocalizedString("Mood/Emotion", comment: ""),
//                     NSLocalizedString("Evidence for the Thought", comment: ""),
//                     NSLocalizedString("Evidence Against the Thought", comment: ""),
//                     NSLocalizedString("Alternative Thought", comment: ""),
//                     NSLocalizedString("Outcome", comment: "")]
//
//    var explainedStep = [ NSLocalizedString("-Where where you? \n-What were you doing? \n-Who were you with?",comment: ""),
//                          NSLocalizedString("-What thoughts were going through your mind? \n-What memories or images were in my mind?", comment: ""),
//                          NSLocalizedString("-Emotions can be described with one word \n E.g angry,sad,scared \n rate 0-100%", comment: ""),
//                          NSLocalizedString("-What facts support the truthfulness of this thought or image?",comment: ""),
//                          NSLocalizedString("-What experiences indicate that this thought is not completely true all of the time? \n-If my best friend had this thought what would I tell them? \n-Are there any small experiences which contradict this thought?",comment: ""),
//                          NSLocalizedString("-Write a new thought which takes into account the evidence for and against the original thoughts",comment: ""),
//                          NSLocalizedString("-How do you feel about the situation now? \n Rate 0-100%",comment: "")]
    
    @ObservedObject var dairyForm = DairyForm()
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    var body: some View {
        
        NavigationView {
            
            ZStack (alignment: .bottom) {
                VStack(alignment: .center) {
                                        
                    //Calendar
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
                    .padding(.top)
                    Divider()
                    
                    VStack(spacing:0) {
                        
                        // Title
                        Text(dairyForm.formTitle[selectedPage])
                            .underline()
                            .foregroundColor(Color("Myblue"))
                            .font(.system(size: 23))
                            .fontWeight(.bold)
                            .opacity(0.5)

                        // Buttons
                        VStack(spacing:-20) {
                        HStack{
                            Button("1") {withAnimation { selectedPage = 0 }}
                            .padding()
                            .background(trigger.isEmpty ?
                                        Circle().fill(Color.gray):
                                        Circle().fill(Color("Myblue")))
                            .scaleEffect(selectedPage == 0 ? 1 : 0.65)
                            
                            
                            
                            
                            Button("2") {withAnimation { selectedPage = 1 }}
                            .padding()
                            .background(autoThought.isEmpty ?
                                        Circle().fill(Color.gray):
                                        Circle().fill(Color("Myblue")))
                            .scaleEffect(selectedPage == 1 ? 1 : 0.65)
                            
                            
                            Button("3") {withAnimation { selectedPage = 2 }}
                            .padding()
                            .background(emotions.isEmpty ?
                                        Circle().fill(Color.gray):
                                        Circle().fill(Color("Myblue")))                     .scaleEffect(selectedPage == 2 ? 1 : 0.65)
                            
                            Button("4") {withAnimation { selectedPage = 3 }}
                            .padding()
                            .background(EFT.isEmpty ?
                                        Circle().fill(Color.gray):
                                        Circle().fill(Color("Myblue")))
                            .scaleEffect(selectedPage == 3 ? 1 : 0.65)
                            
                            
                        }
                        HStack{
                        
                            Button("5") {withAnimation { selectedPage = 4 }}
                            .padding()
                            .background(EAT.isEmpty ?
                                        Circle().fill(Color.gray):
                                        Circle().fill(Color("Myblue")))
                            .scaleEffect(selectedPage == 4 ? 1 : 0.65)

                            
                            Button("6") {withAnimation { selectedPage = 5 }}
                            .padding()
                            .background(alterThought.isEmpty ?
                                        Circle().fill(Color.gray):
                                        Circle().fill(Color("Myblue")))                   .scaleEffect(selectedPage == 5 ? 1 : 0.65)
                            Button("7") {withAnimation { selectedPage = 6
                                print("Hello")
                            }}
                            .padding()
                            .background(outcome.isEmpty ?
                                        Circle().fill(Color.gray):
                                        Circle().fill(Color("Myblue")))                   .scaleEffect(selectedPage == 6 ? 1 : 0.65)
                        }
                    }
                        .font(.title2)
                        .foregroundColor(.white)
                        
                        
                        // TabView
                        TabView(selection: $selectedPage) {
                            
                            FormView(input: $trigger, formTitle: dairyForm.formTitle[0], flag2: $flag2)
                                .tag(0)
                            
                            FormView(input: $autoThought, formTitle: dairyForm.formTitle[1], flag2: $flag2)
                                .tag(1)
                            
                            FormView(input: $emotions, formTitle: dairyForm.formTitle[2], flag2: $flag2)
                                .tag(2)
                            
                            FormView(input: $EFT, formTitle: dairyForm.formTitle[3], flag2: $flag2)
                                .tag(3)
                            
                            FormView(input: $EAT, formTitle: dairyForm.formTitle[4], flag2: $flag2)
                                .tag(4)
                            
                            FormView(input: $alterThought, formTitle: dairyForm.formTitle[5], flag2: $flag2)
                                .tag(5)
                            
                            FormView(input: $outcome, formTitle: dairyForm.formTitle[6], flag2: $flag2)
                                .tag(6)
                            
                        }
                        .frame(height: 230)
                        .tabViewStyle(.page(indexDisplayMode: .never))

                        
                        VStack() {
                            HStack(spacing:3) {
                              
                                Text("Hints for")
                                    .font(.system(size: 14))
                                Text(dairyForm.formTitle[selectedPage])
                                    .font(.system(size: 14))

                                Image(systemName: "questionmark.circle.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color("Myred"))
                                    .onTapGesture {
                                        self.flag2 = true
                                    }
                                Spacer()
                                
                            }
                            .transition(.opacity)
                            .padding(.horizontal,20)

                            
                            
                            HStack {
                                
                                Button(action: {
                                    withAnimation(){
                                        self.selectedPage -= 1
                                    }
                                }, label: {
                                    Text("Previous")
                                        .font(.callout)
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding()
                                        .background(selectedPage == 0 ? Color.gray: Color("Myblue"))
                                        .cornerRadius(20)
                                        .shadow(radius: 3)
                                }).disabled(selectedPage==0)
                                
                                if selectedPage == 6 {
                                    
                                    Button(action: {
                                        withAnimation(){
                                            
                                            let newThought = ThoughtRecord(context: viewContext)
                                            print(newThought)
                                            newThought.trigger = trigger
                                            newThought.autoThought = autoThought
                                            newThought.emotion = emotions
                                            newThought.eft = EFT
                                            newThought.eat = EAT
                                            newThought.alterThought = alterThought
                                            newThought.outcome = outcome
                                            newThought.decodedDate = selectedDate
                                            newThought.selectedDate = MainDiary.formatter.string(from: self.selectedDate)
                                            newThought.time = selectedDate.time
                                            newThought.year = selectedDate.year
                                            newThought.month = selectedDate.month
                                            newThought.day = selectedDate.day
                                            saveContext()
                                            self.isPresented.toggle()
                                            
                                        }
                                        
                                    }, label: {
                                        Text("Add")
                                            .font(.callout)
                                            .foregroundColor(.white)
                                            .bold()
                                            .padding()
                                            .background(Color("Myblue"))
                                            .cornerRadius(20)
                                            .shadow(radius: 3)
                                        
                                    })
                                    //.animation(.spring())
                                    
                                    
                                } else {
                                    
                                    
                                    
                                    Button(action: {
                                        withAnimation(){
                                            self.selectedPage += 1
                                        }
                                        
                                    }, label: {
                                        Text("Next")
                                            .font(.callout)
                                            .foregroundColor(.white)
                                            .bold()
                                            .padding()
                                            .background(Color("Myblue"))
                                            .cornerRadius(20)
                                            .shadow(radius: 3)
                                        
                                    })
                                }
                                
                            }
                        }
                        .padding(.top,-10)
                    }
                 
                    Spacer()
                    
                }
                
                if flag2 {
                    Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
                        .scaleEffect()
                        .onTapGesture {
                            self.flag2.toggle()
                        }
                    
                    VStack(alignment:.leading,spacing:10) {
                        HStack {
                            Spacer()
                            Text(dairyForm.formTitle[selectedPage])
                                .underline()
                                .foregroundColor(Color.white)
                                .font(.system(size: 23))
                                .fontWeight(.bold)
                                .opacity(0.8)
                            
                            Spacer()
                            
                        }
                        .padding(5)
                        .background(Color("Myblue"))
                        
                        Text(dairyForm.explainedStep[selectedPage])
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .padding(5)
                            .padding(.horizontal,10)
                        
                        Spacer()
                    }
                    .frame(width:UIScreen.main.bounds.width,height: 225)
                    .background(Color.primary.colorInvert()).cornerRadius(50)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
                    .zIndex(0)
                    
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
                
                
            }
            .navigationBarTitle("CBT Thought Record",displayMode: .inline)
            .edgesIgnoringSafeArea(.bottom)
            .multilineTextAlignment(.center)
            .ignoresSafeArea(.keyboard)

        }
        .onTapGesture {
                    hideKeyboard()
            }
                
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
            
        } catch  {
            let error = error as NSError
            fatalError("Opsy: \(error)")
        }
    }
    
}



struct MainDiary_Previews: PreviewProvider {
    static var previews: some View {
        MainDiary(isPresented: .constant(false))
        
    }
    
}



struct FormView: View {
    
    @Binding var input : String
    @State var formTitle : String
    @State var placeHolder = "..."
    @Binding var flag2: Bool
    
    
    var body: some View {
        VStack() {
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                Rectangle()
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(height: 200)
                    .shadow(radius: 5)
                
                TextEditor(text: $input)
                    .padding(EdgeInsets(top: -7, leading: -4, bottom: -7, trailing: -4))
                    .font(.system(size: 17))
                    .padding()
                    .background(Color.white)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .multilineTextAlignment(.leading)
                
                if input.isEmpty {
                    TextField(NSLocalizedString(placeHolder, comment: ""), text: $input)
                        .padding()
                        .disabled(true)
                        .multilineTextAlignment(.leading)
                    // don't allow for it to be tapped
                }
                
            }
            
        }.padding(.horizontal)
        
    }
}



