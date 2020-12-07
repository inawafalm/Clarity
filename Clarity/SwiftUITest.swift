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
    @State private var selectedDate = Date()

    var body: some View {
        
        DatePicker("", selection: $selectedDate)
        
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
    }
}




