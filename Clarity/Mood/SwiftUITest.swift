//
//  SwiftUITest.swift
//  Clarity
//
//  Created by Nawaf Almutairi on 10/21/20.
//

import SwiftUI

struct testStruct: Identifiable {
    var id = UUID()
    var name : String
}

var arrayTest : [testStruct] = [testStruct(name: "1"),testStruct(name: "2")]

struct SwiftUITest: View {
    
    @State var show = false
    @State var indexArray: Int?
    @State var selectedMood: testStruct? = nil
    
    var body: some View {
        
        List {
            ForEach(Array(arrayTest.enumerated()), id: \.1.id) { (index , item) in
                VStack {
                    Text(item.name)
                        .bold()
                        .padding(20)
                    Text("\(index)")
                }
                .onTapGesture{
                    indexArray = index
                    selectedMood = item
                    self.show.toggle()
                }
            }
           
        }
        .sheet(item: self.$selectedMood) { mood in
            SwiftUITest2(isPresented: $show, text: mood.name)
        }
        
        
    }
}


struct SwiftUITest2: View {
    
    @Binding var isPresented: Bool
    var text : String
    
    var body: some View {
        
      //  Text("\(indexArray ?? 3)")
        Text(text)
            .bold()
            .font(.title)
        
    }
}

struct SwiftUITest_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUITest()
        SwiftUITest2(isPresented: .constant(false), text: "")
    }
}




