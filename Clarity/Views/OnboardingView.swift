//
//  OnboardingView.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 02/12/2021.
//

import Foundation
import SwiftUI


struct Onboarding: View {
    
    @Binding var onboarding : Bool
    
    var body: some View {
        
        VStack(spacing:35){
                
            VStack {
                Image("clarity")
                    .resizable()
                    .clipShape(Circle())
                .frame(width: 100, height: 100)
                
                Text("What's in \nClarity")
                    .font(.headline)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            
                HStack(){
                    Image(systemName: "magnifyingglass.circle")
                        .font(.system(size: 35))

                    VStack(alignment:.leading) {
                        Text("Mood Tracker")
                            .font(.title3)
                            .bold()
                        Text("• A daily mood tracker and journal tool.")
                            .font(.callout)

                    }
                    Spacer()
                    .offset(y: -10)
                }
                .frame(width: 350)

            
            HStack{
                Image(systemName: "hand.raised")
                    .font(.system(size: 35))

                VStack(alignment:.leading) {
                    Text("Privacy")
                        .font(.title3)
                        .bold()
                    Text("• No content, including journal entries and any activity will be saved, tracked or even backed up in our servers. \n • Using icloud to backup your entries.")
                        .font(.callout)
                        
                }
                Spacer()

                .offset(y: -10)
            }
            .frame(width: 350)

            Spacer()
            Button(action: {
                
                self.onboarding = false
                
            }) {
                Text("Continue")
                    .font(.title3)
                    .bold()
                    .foregroundColor(Color.white)
            }.padding()
                .padding(.horizontal,30)
                .background(Color("Myblue"))
                .cornerRadius(20)
                .animation(.spring())
                .padding(.bottom,50)
               
                
            }
        .multilineTextAlignment(.leading)

            .frame(width: UIScreen.main.bounds.width)
            
            .padding(.top,70)
            //.background(LinearGradient(gradient: Gradient(colors: [Color("Myblue"), .white]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .edgesIgnoringSafeArea(.all)
    }
    
}

