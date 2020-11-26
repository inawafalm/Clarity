//
//  TweetFeed.swift
//  life
//
//  Created by Nawaf Almutairi on 7/1/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI

// TODO
// Expand the tweet
// make the like button clickable, countable.

// Get Screenn size
struct Screen {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
}

// Item for data
struct ContentStruct : Identifiable {
    var id: Int
    var title : String
    var subTitle : String
    var image : String
    var content : String
}


var contentAppeared = [
    ContentStruct(id: 0, title: "Managing Anixety", subTitle: "Learn more and keep learning.", image: "Yoga", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet."),
    
    ContentStruct(id: 1, title: "2", subTitle: "Learn more and keep learning", image: "CBT", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet."),
    ContentStruct(id: 2, title: "3", subTitle: "Learn more and keep learning", image: "CBT", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet."),
   ContentStruct(id: 3, title: "4", subTitle: "Learn more and keep learning", image: "CBT", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.")
    
]




struct testFeedView: View {
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 1)
    @State var show = false
    @State var appear = false

    @State var selected : ContentStruct = contentAppeared[0]
    @Namespace var name
    
    var body: some View {
        
        
        ZStack{
            
            // Grid
            ScrollView(.vertical, showsIndicators: false) {
                
                HStack{
                    
                    Text("Articles")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    	
                    Button(action: {}) {
                        
                        Image(systemName: "person")
                            .renderingMode(.original)
                        
                    }
                }
                // due to top area is ignored...
                .padding([.horizontal,.top])
                
                ZStack {
                    LazyVGrid(columns: columns , spacing:25){
      
                        ForEach(contentAppeared) { content in
                            VStack(alignment: .leading, spacing: 10) {
                                ZStack{
                                    
                                    // Image
                                    VStack {
                                        Image(content.image)
                                            .resizable()
                                            .blur(radius: 0.8)
                                            .aspectRatio(contentMode: .fit)
                                            .matchedGeometryEffect(id: content.id, in: name)
                                            .frame(width: 200, height: 200, alignment: .center)

                                        }
                                        .padding()
                                    
                                    //SubTitle and Title
                                    HStack {
                                        Spacer()
                                        VStack(alignment: .center, spacing: 0) {
                                            Text(content.subTitle)
                                                .font(.title3)
                                                .foregroundColor(.white)
                                                .fontWeight(.heavy)
                                            
                                            Text(content.title)
                                                .font(.title2)
                                                .fontWeight(.heavy)
                                                .foregroundColor(.white)
                                                .matchedGeometryEffect(id: content.title, in: name)
                                            
                                        }
                                        Spacer()
                                    }
                                    
                                    .onTapGesture {
                                        show.toggle()
                                        selected = content
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                            appear.toggle()
                                        }
                                    }
                                }
                                .background(Color("Myblue"))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                            }
                        }
                    }

                    .padding([.horizontal,.bottom])
                }
                
                
            }
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            
            // Hero View...
            if show == true {
                
                ScrollView(.vertical, showsIndicators: false){
                    ZStack{
                        
                        
                        VStack{
                            HStack {
                                
                                Spacer()
                                if appear {
                                    Button(action: {
                                        
                                        show.toggle()
                                        appear.toggle()
                                        
                                    }) {
                                        
                                        Image(systemName: "xmark")
                                            .foregroundColor(.black)
                                            .padding(10)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                    }
                                }
                                
                            }.padding(25)
                            Text(selected.title)
                                .matchedGeometryEffect(id: selected.title, in: name)
                            Image(selected.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .matchedGeometryEffect(id: selected.id, in: name)
                                .frame(width: 250, height: 300, alignment: .center)
                        }
                        .background(Color("Myblue"))
                        .cornerRadius(20)
                    }
                    if appear {
                    ScrollView {
                        VStack {
                            Text(selected.content)
                            Divider()
                        }
                        .padding()
                        VStack(spacing:10){
                            Image(systemName: "heart")
                                .font(.title)
                            Text("20")
                        }
                    }
                }
                    Spacer()
                    
                    
                }
                .background(Color.white)
                .edgesIgnoringSafeArea(.all)
                
            }
            
            
        }
        .navigationBarHidden(true)
        .animation(.easeInOut)
        //.animation(Animation.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8))
        
        
    }
    
}



struct expandView: View {
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            
            
            ZStack{
                
                VStack{
                    HStack {
                        Spacer()
                        Button(action: {
                            
                            //withAnimation(.spring()){show.toggle()}
                            
                        }) {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }.padding(25)
                    //Spacer()
                    
                    Image("Yoga")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 300, alignment: .center)
                }
                .background(Color("Myblue"))
                .cornerRadius(20)
            }
            
            VStack {
                Text("Hi")
                Divider()
            }
            .padding()
            
            VStack(spacing:10){
                Image(systemName: "heart")
                    .font(.title)
                Text("20")
            }
            Spacer()
                    
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
     
    }
    
    
}


struct testView_Previews: PreviewProvider {
    
    static var previews: some View {
        testFeedView()
        expandView()
        
    }
}

