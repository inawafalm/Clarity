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


struct SwiftUITest: View {
    

    @State var traficSignal = true
    
    var body: some View {
        
        Button(action: {
            traficSignal.toggle()
        }, label: {
            
            Circle()
                .foregroundColor(traficSignal ? Color.red : Color.green)
            
        })
        
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




