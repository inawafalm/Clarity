//
//  ExerciceView.swift
//  life
//
//  Created by Nawaf Almutairi on 6/4/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI

struct ExerciceView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
    
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "multiply.circle")
                        .font(.title)
                        .onTapGesture {
                            // something here to drop the view.
                            presentationMode.wrappedValue.dismiss()
                    }
                }
                Image("Yoga")
                    .resizable()
                    .frame(width: 250, height: 250)
                    .clipShape(Circle())
                Text("Yoga")
                    .font(.title)
                
                Text("Reducing Anger: In one study of adolescents (2012), yoga was shown to increase one's ability to control anger, compared to a group that participated only in physical education. Practicing yoga has also been shown to decrease verbal aggression in adults.").padding()
                Text("2. Reducing Anxiety: Numerous studies have found that yoga may decrease anxiety symptoms, including performance anxiety. In one study (2013) with adolescent musicians, yoga decreased anxiety in group and solo performances. ").padding()
                Divider()
                Text("Sources:")
                    .font(.headline)
                HStack(spacing:30) {
                    VStack {
                        Image("downDog").resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                        Text("Down Dog")
                        .underline()

                    }
                    VStack {
                        Image("downDog").resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                        Text("Down Dog")
                        .underline()

                    }
                    VStack {
                        Image("downDog").resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                        Text("Down Dog")
                        .underline()

                    }
                    
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ExerciceView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciceView()
    }
}
