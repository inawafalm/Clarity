//
//  SwiftUITest.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 19/11/2021.
//

import SwiftUI

struct SwiftUITest: View {
    
    @State var selectedPage = 0
    @State var trigger : String = ""
    @State var autoThought : String = ""
    @State var emotions : String = ""
    @State var EFT : String = ""
    @State var EAT : String = ""
    @State var alterThought : String = ""
    @State var outcome : String = ""
    
    let data = ["1","2","3","4","5","6","7"]

       let columns = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
       ]

    
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(data.indices, id: \.self) { index in
                            Text(data[index])
                                .padding()
                                .background(trigger.isEmpty ?
                                Circle().fill(Color.gray):
                                Circle().fill(Color("Myblue")))
                
                                .scaleEffect(selectedPage == index ? 1 : 0.65)
                                .onTapGesture {
                                    //selectedPage = item.count
                                    selectedPage = index
                                }
                        }
                    }
                    //.padding(.horizontal)
         
    }
}

struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest()
    }
}
