//
//  describeView.swift
//  life
//
//  Created by Nawaf Almutairi on 2/1/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI





struct describeView: View {
    //dd
    @State var currentMoment: String
    @State var currentMood: [String] = []
    @State var currentActivity: [String] = []
    @State var peopleWith: [String] = []
    @State var currentPlace: [String] = []
    @State var selectedDate = Date()
    let monthComponents = Calendar.current.shortMonthSymbols
    @Environment(\.managedObjectContext) var viewContext
    



    
    @State private var input = ""
    @Binding  var  isPresented: Bool
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        
        
            VStack{
                
                Image("MoodTrack")
                    .resizable()
                    .frame(width: 100 , height: 100)
                    .padding(.top,70)
                
                Text("Journaling")
                    .foregroundColor(Color("Myblue"))
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .opacity(0.5)
                
                Text("Journaling. It's simply writing down your thoughts and feelings to understand them more clearly.")
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .lineLimit(3)
                
                
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
                         TextField(NSLocalizedString("What Happend ?", comment: ""), text: $input)
                               .padding()
                           .disabled(true)
                           .multilineTextAlignment(.leading)
                           // don't allow for it to be tapped
                       }
                    
                }
                .padding()
                
                

                Button(action: {

                    let newMood = Mood(context: viewContext)
                    print(newMood)
                    newMood.currentMoment = currentMoment
                    newMood.currentMood = stringArrayToData(stringArray: currentMood)
                    newMood.currentActivity = stringArrayToData(stringArray: currentActivity)
                    newMood.peopleWith = stringArrayToData(stringArray: peopleWith)
                    newMood.currentPlace = stringArrayToData(stringArray: currentPlace)
                    newMood.journaling = input
                    newMood.decodedDate = selectedDate
                    newMood.selectedDate = describeView.formatter.string(from: self.selectedDate)
                    newMood.time = selectedDate.time
                    newMood.year = selectedDate.year
                    newMood.month = selectedDate.month
                    newMood.day = selectedDate.day
                    

                    saveContext()
                    self.isPresented.toggle()
                    
                }, label: {
                    Text("Add")
                        .foregroundColor(.white)
                        .buttonStyle(buttonChoiceStyle())
                    .shadow(radius: 3)
                })
                Spacer()
            }
           // .multilineTextAlignment(.center)


        
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

#if DEBUG
struct describeView_Previews: PreviewProvider {
    @State var isPresentedPreview = false
    static var previews: some View {
       
        
        Group {
            describeView(currentMoment: "", currentMood: [""], currentActivity: [""], peopleWith: [""], currentPlace: [""], isPresented: .constant(false))
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
                .previewDisplayName("iPhone 12 Pro Max")
//
//            describeView(currentMoment: "", currentMood: [""], currentActivity: [""], peopleWith: [""], currentPlace: [""], isPresented: .constant(false))
//                .previewDevice(PreviewDevice(rawValue: "iPhone 12 pro"))
//                .previewDisplayName("iPhone 12 pro")
//
//            describeView(currentMoment: "", currentMood: [""], currentActivity: [""], peopleWith: [""], currentPlace: [""], isPresented: .constant(false))
//                .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
//                .previewDisplayName("iPhone 12 mini")
//
//            describeView(currentMoment: "", currentMood: [""], currentActivity: [""], peopleWith: [""], currentPlace: [""], isPresented: .constant(false))
//                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//                .previewDisplayName("iPhone 8")
            
        }
        
    }
}
#endif
