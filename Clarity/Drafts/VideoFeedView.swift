//
//  VideoFeedView.swift
//  life
//
//  Created by Nawaf Almutairi on 6/4/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI

// TODO
// Maybe change the design little bit
// make it white.

struct VideoFeedView: View {
    
   // @Binding var  isPresented: Bool

    var body: some View {
            VStack {
                Form {
                    List {
                        ForEach(0 ..< 3) {_ in
                            ZStack(alignment: .trailing){
                                Image("VideoThumbnail")
                                    .resizable()
                                    .frame(height: 200)
                                LinearGradient(gradient: Gradient(colors: [.clear,Color.black.opacity(0.7)]
                                ), startPoint: .top, endPoint: .bottom)
                                VStack(alignment: .trailing){
                                    Spacer()
                                    Text("أهمية الصحة النفسية | بودكاست فنجان")
                                        .font(.headline)
                                        .foregroundColor(Color.white)
                                    Text("د.محمد السويدان")
                                        .fontWeight(.light)
                                        .foregroundColor(Color.white)
                                }.padding(10)
                            }.cornerRadius(10)
                                .padding(.top,10)
                                .padding(.horizontal,5)
                                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                                .shadow(radius: 5)
                        }
                        .listRowBackground(Color.init(UIColor(red: 0.90, green: 0.92, blue: 0.91, alpha: 1.00)))
                    }
                    .padding(.horizontal,10)
                }
                    
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().separatorColor = UIColor(red: 0.90, green: 0.92, blue: 0.91, alpha: 1.00)
                    UITableView.appearance().backgroundColor = UIColor(red: 0.90, green: 0.92, blue: 0.91, alpha: 1.00)
                }
            }
            .navigationBarTitle("Interviews",displayMode: .inline)
            .listStyle(GroupedListStyle())
    }
}

struct VideoFeedView_Previews: PreviewProvider {
    static var previews: some View {
        VideoFeedView()
        //isPresented: .constant(false)
    }
}
