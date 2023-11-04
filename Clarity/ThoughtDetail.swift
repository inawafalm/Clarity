//
//  ThoughtDetail.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 14/11/2021.
//

import SwiftUI

struct ThoughtDetail: View {
    
    
    var thoughtDetail = ThoughtStructure(trigger: "", autoThought: "", emotions: "", EFT: "", EAT: "", alterThought: "", outcome: "", decodedDate: Date(), selectedDate: "", time: "", year: "", month: "", day: "")

    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @Binding  var  isPresented: Bool
    

    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
    
        
        ScrollView {

            VStack{
                // X Mark
                HStack {

                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()

                    }) {

                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
                .offset(y: 20)
                .padding(.horizontal)


                // Date
                VStack(spacing:5){
                    Image(systemName:"calendar")
                        .font(.title)
                    Text(thoughtDetail.selectedDate)
                        .underline()
                        .font(.system(size: 20))
                }
                .foregroundColor(Color.white)
                Divider()

            }
            .padding(.top)
            .background(Color("Myblue"))
            .cornerRadius(20)
            
            formView(title: NSLocalizedString("Situation / Trigger",comment: ""), content: thoughtDetail.trigger)
            
            formView(title: NSLocalizedString("Mood/Emotion",comment: ""), content: thoughtDetail.emotions)
            
            formView(title: NSLocalizedString("Automatic Thoughts",comment: ""), content: thoughtDetail.autoThought)
            
            formView(title: NSLocalizedString("Evidence for the Thought",comment: ""), content: thoughtDetail.EFT)
            
            formView(title: NSLocalizedString("Evidence Against the Thought",comment: ""), content: thoughtDetail.EAT)
            
            formView(title: NSLocalizedString("Alternative Thought",comment: ""), content: thoughtDetail.alterThought)
            
            formView(title: NSLocalizedString("Outcome",comment: ""), content: thoughtDetail.outcome)
            

            Spacer()
        }
        .edgesIgnoringSafeArea(.all)

    }
}

struct ThoughtDetail_Previews: PreviewProvider {
    static var previews: some View {
        ThoughtDetail(thoughtDetail: ThoughtStructure(trigger: "", autoThought: "", emotions: "", EFT: "", EAT: "", alterThought: "", outcome: "", decodedDate: Date(), selectedDate: "", time: "", year: "", month: "", day: ""),isPresented: .constant(false))
    }
}

struct formView: View {
    
    @State var title : String
    @State var content : String
    @State var isShowing = false
    
    var body: some View {
        VStack(spacing:5) {
            Divider()
            HStack {
                Text(title)
                .foregroundColor(Color("Myblue"))
                .font(.system(size: 24))
                .fontWeight(.bold)
                .opacity(0.5)
                withAnimation(){
                Image(systemName: isShowing ? "arrow.up.circle" : "arrow.down.circle")
                }

                Spacer()
            }
            .onTapGesture {
                withAnimation() {
                self.isShowing.toggle()
                }
            }
            .padding(.horizontal)
            
            if isShowing == false {
                Text(content)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity,
                           minHeight: 200, maxHeight: 600,alignment: .topLeading)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    .onAppear {
                        withAnimation(Animation.easeIn(duration: 0.6).delay(0.4)) {
                        }
                    }
            
            }
          
        }
    }
}
