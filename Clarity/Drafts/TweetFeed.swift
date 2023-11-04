//
//  TweetFeed.swift
//  life
//
//  Created by Nawaf Almutairi on 7/1/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI
import Kingfisher

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




struct FeedView: View {
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 1)
    @State var show = false
    @State var appear = false

    @State var selectedLanguage = true
    @State var selectedContent: Posts? = nil
    @State var isPresentingContent = false

    @ObservedObject var postModel = PostsModel()

    @Namespace var name
    
    var body: some View {
        
        
            
            // Grid
            ScrollView{
                
                HStack(spacing:20) {
                    
                    VStack(spacing:5) {
                
                        Text("English")
                            .foregroundColor(Color("Myblue"))
                            .opacity(selectedLanguage ? 1.0 : 0.65)
                            .onTapGesture {
                                withAnimation(.spring()){selectedLanguage.toggle()}
                        }
                        if selectedLanguage{
                        Circle().frame(width: 5, height: 5)
                            .foregroundColor(Color("Myblue"))
                            .matchedGeometryEffect(id: "L", in: name)
                        }
                        else {
                            Circle().frame(width: 5, height: 5)
                                .foregroundColor(.white)
                        }
                    }
                    
                    VStack(spacing:5) {
                
                        Text("Arabic")
                            .foregroundColor(Color("Myblue"))
                            .opacity(selectedLanguage ? 0.65 : 1.0)
                            .onTapGesture {
                                withAnimation(.spring()){selectedLanguage.toggle()}
                        }
                        if selectedLanguage == false {
                        Circle().frame(width: 5, height: 5)
                            .foregroundColor(Color("Myblue"))
                            .matchedGeometryEffect(id: "L", in: name)
                        } else {
                            Circle().frame(width: 5, height: 5)
                                .foregroundColor(.white)
                        }
                        
                    }
                    Spacer()
                    
                }
                .font(.custom("Apercu-bold", size: 22))
                .padding(10)
                .padding(.top,75)
                
                
                Divider()
                
                
//                ForEach(postModel.post, id: \.self) { item in
//
//                        ZStack(alignment: .topLeading) {
//                                KFImage(URL(string: item.featured_image))
//                                    .resizable()
//                                    .scaledToFit()
//                                    .cornerRadius(20)
//                                    //.blur(radius: 0.8)
//
//                                ZStack {
//                                    Rectangle()
//                                        .fill(Color.black)
//                                        .frame(height: 75)
//                                        .opacity(0.5)
//                                        .cornerRadius(radius: 20, corners: [.topLeft, .topRight]).opacity(0.8)
//
//                                    HStack() {
//                                        VStack(alignment:.leading){
//                                                Text(item.title)
//                                                    .font(.custom("Apercu-Regular", size: 20))
//                                                    .foregroundColor(.white)
////                                                    .font(.custom("Apercu-Regular", size: 17))
////                                                    .foregroundColor(.white)
//                                            }
//                                            .padding(5)
//                                            Spacer()
//
//                                        }
//                                }
//
//                            }
//                            .clipped()
//                        .shadow(radius: 1,y: 3)
//                        .onTapGesture {
//                            self.selectedContent = item
//                            self.isPresentingContent.toggle()
//                        }
//                }
//                .padding(.horizontal)
//                .padding(.top,5)

            }
//
//        .onAppear() {
//            postModel.fetchPostsJSON { (res) in
//                switch res {
//                case .success(let post):
//                    post.forEach { (ps) in
//                       print("Hola, it's working",ps)
//
//                    }
//                case .failure(let err):
//                    print("Failed to fetch posts: ",err)
//                }
//            }
//        }
            
        
        .background(EmptyView()).fullScreenCover(item: self.$selectedContent, onDismiss: {
            self.isPresentingContent = false
        }, content: { content in
            expandView(content: content, isPresented: $isPresentingContent)
            
        })
        
            .edgesIgnoringSafeArea(.top)
            .statusBar(hidden: isPresentingContent)
        
        
        
    }
    
}



struct expandView: View {
    
    @State var content = Posts(id: 1, title: "", content: "mklmlkdmfklsdm", featured_image: "https://i1.wp.com/claritymind.co/wp-content/uploads/2021/01/ELfNPfCX0AMwrpH.jpg?fit=1024%2C576&ssl=1")
    @Binding var  isPresented: Bool
    @Environment(\.presentationMode) var presentationMode


    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            ZStack{
                VStack {
                    KFImage(URL(string: content.featured_image))
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                    Spacer()
                }
                VStack{
                    HStack {
                        Spacer()
                        Button(action: {

                            withAnimation(.spring()){presentationMode.wrappedValue.dismiss()}

                        }) {

                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }.padding()

                    Spacer()
                }
            }.frame(height: 250)
            
            
            VStack() {
                Text("textTest.removeHTMLTag().removeNBSP()")
                    .font(.custom("Apercu-Regular", size: 17))
                    .multilineTextAlignment(.trailing)
                    .lineSpacing(5)
                Divider()
            }
            .padding()
            
            VStack(spacing:10){
                Image(systemName: "heart")
                    .font(.title)
                Text("20")
                    .font(.custom("Apercu-Light", size: 17))
                    .offset(y:-8)
                
            }
            Spacer()
                    
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .animation(.easeIn)
    }
    
    
}


struct testView_Previews: PreviewProvider {
    
    static var previews: some View {
        FeedView()
        expandView(isPresented: .constant(false))
        
    }
}


struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
