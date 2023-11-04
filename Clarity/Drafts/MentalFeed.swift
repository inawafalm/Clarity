//
//  MentalFeed.swift
//  life
//
//  Created by Nawaf Almutairi on 6/1/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI

// Edit the Animation when closing the tab.

struct ExerciceBox:Identifiable {
    let id = UUID()
    let exerciceText,exerciceImage : String
}
struct ContentBox:Identifiable {
    var id = UUID()
    
    let contentText,contentImage : String
    let destination:  AnyView
}

struct MentalFeed: View {
    
    @State var isPresentingExercise = false
    @State var isPresentingVideo = false
    @State var isPresentingTweet = false

    
    @State private var selection: String? = nil
    @State private var isShowingDetailView = false
    @State private var contentViewPrepare = ""
    @State private var contentViewSelector: Int? = nil
    
    let contentArray = [
        ["Videos","Courses"]
    ]
    
    
    @Namespace var animation
    @State var show = false
   // @State var selected : ContentStruct = contentAppeared[0]
    
    
    let exerciceBox:[ExerciceBox] = [
        ExerciceBox(exerciceText: "Yoga", exerciceImage: "Yoga"),
        ExerciceBox(exerciceText: "Meditation", exerciceImage: "Meditation"),
        ExerciceBox(exerciceText: "MoodTrack", exerciceImage: "MoodTrack"),
        ExerciceBox(exerciceText: "CBT", exerciceImage: "CBT")
    ]
   
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack{
                    
                    // Hstack for Exercices Text
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Exercices").font(.title).bold()
                        }
                        Spacer()
                    }.padding(.top)
                    .padding(.horizontal)

                    
                    // ScrollView
                    ScrollView(.horizontal,showsIndicators: false, content: {
                         HStack() {
                             ForEach(exerciceBox) { exercice in
                                 highlightView(exericesText: exercice.exerciceText, exerciceImage: exercice.exerciceImage)
                                     .frame(width:300, height: 200)
                                     .padding()
                                     .onTapGesture {
                                         self.isPresentingExercise.toggle()
                                 }
                             }
                         }
                     })
                    
                    Divider()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Content").font(.title).bold()
                            
                        }
                        Spacer()
                    }.padding(.top)
                    .padding(.horizontal)
                    
                    ScrollView(.vertical,showsIndicators: false, content: {
                        VStack {
                            ForEach(self.contentArray, id: \.self) { row in
                                ZStack {
                                    HStack() {
                                       
                                        ForEach(row, id: \.self) { categoryName in
                                            
                                            categoryView(categoryImage: categoryName, categoryName: categoryName)
                                                .frame(width:175, height: 230)
                                                .padding(5)
                                                .onTapGesture {
                                                    if categoryName == "Videos" {
                                                    self.isPresentingVideo = true
                                                    }
                                                    else {
                                                        self.isPresentingTweet = true
                                                    }
                                            }
                                                                                        
                                        }
                                    }
                                    
                                }
                                
                            }
                        }
                        
                    })
                    
                     NavigationLink(destination: VideoFeedView(), isActive: self.$isPresentingVideo){EmptyView()}
//                    NavigationLink(destination: testFeedView(), isActive: self.$isPresentingTweet){EmptyView()}

                    
                }
            }
            .navigationBarTitle("Discovery",displayMode: .large)
            .ignoresSafeArea(edges: .bottom)

        }
        .fullScreenCover(isPresented: $isPresentingExercise, content: {
            ExerciceView.init()
        })
    }
}

struct MentalFeed_Previews: PreviewProvider {
    static var previews: some View {
        MentalFeed()
    }
}


struct highlightView : View {
    var exericesText = ""
    var exerciceImage = ""
    var body: some View {
        ZStack() {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .foregroundColor(Color("Myblue"))
            VStack() {
                Image(exerciceImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150, alignment: .center)
                    .cornerRadius(30)
                Text(exericesText)
                    .font(.headline)
                    .foregroundColor(Color("Mywhite"))
            }
        }.cornerRadius(30)
    }
}


struct categoryView : View {
    
    var categoryImage = ""
    var categoryName  = ""
    
    
    var body: some View {
        ZStack() {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .foregroundColor(Color("Myblue"))
            HStack(alignment:.center) {
                VStack {
                    Image(categoryImage).resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 175 , height: 175, alignment: .center)
                    Text(categoryName)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Mywhite"))
                        .offset(y: -20)
                }
            }
        }.cornerRadius(30)
    }
}

