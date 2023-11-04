//
//  Styles.swift
//  life
//
//  Created by Nawaf Almutairi on 4/28/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI


struct textChoiceStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 10.0)
            .contentShape(Rectangle())
            .foregroundColor(Color("Myblue"))
            .background(Color("Mywhite"))
            .cornerRadius(20)
            .shadow(radius: 5)
        
    }
}


struct textChoiceStyle2: ViewModifier {
    
    @State var tapped = ""
    @State var moodData = ""
    
    func body(content: Content) -> some View {
        content
            .padding(.all, 10.0)
            .contentShape(Rectangle())
            .foregroundColor(tapped == moodData ? Color("Mywhite"): Color("Myblue"))
            .background(tapped == moodData ? Color("Myblue"): Color("Mywhite"))
            .cornerRadius(20)
            .shadow(radius: 5)
        
    }
}



struct MyButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.all, 10.0)
            .contentShape(Rectangle())
            .background(configuration.isPressed ? Color.red : Color("Mywhite"))
            .cornerRadius(20)
            .shadow(radius: 5)
        
    }
    
}



struct buttonChoiceStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("Myblue"))
            .cornerRadius(20)
            .animation(.spring())
    }
}

struct DbuttonChoiceStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("Myblue"))
            .cornerRadius(20)
            .animation(.spring())
    }
}


//Mood Cells circles.
struct textChoiceStyleCell: ViewModifier {
    var colorName: String
    func body(content: Content) -> some View {
        content
            .padding(.all, 6.0)
            .contentShape(Rectangle())
            .background(Color(colorName))
            .cornerRadius(20)
    }
}

extension View {
    func textChoiceStyleCellModifier(with colorName: String) -> some View {
        self.modifier(textChoiceStyleCell(colorName: colorName))
    }
}

extension View {
    func textChoiceStyleCellModifier2(tapped: String,moodData: String) -> some View {
        self.modifier(textChoiceStyle2(tapped: tapped, moodData: moodData))
    }
}

extension View {
    func buttonStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}

struct NoButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

extension View {
    func delayTouches() -> some View {
        Button(action: {}) {
            highPriorityGesture(TapGesture())
        }
        .buttonStyle(NoButtonStyle())
    }
}


extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        //background color of the navigation and status bar
        appearance.backgroundColor = UIColor(named: "Myblue")
        
        //color when the title is large
        appearance.largeTitleTextAttributes.updateValue(UIColor(named: "Mywhite")!, forKey: NSAttributedString.Key.foregroundColor)

        //color when the title is small
        appearance.titleTextAttributes.updateValue(UIColor(named: "Mywhite")!, forKey: NSAttributedString.Key.foregroundColor)

        
        // change the background- and title foregroundcolor for navigationbar
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        // change color of navigationbar items
        navigationBar.tintColor = UIColor(named: "Myblue")
        UINavigationBar.appearance().tintColor = .white

    }
}
//


extension String {
    

   func removeHTMLTag() -> String {

       return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)

    }
    func removeNBSP() -> String {

        return self.replacingOccurrences(of: "&nbsp;", with: "", options: String.CompareOptions.regularExpression, range: nil)
     }

}
