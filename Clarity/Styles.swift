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
           // .foregroundColor(Color("Myblue"))
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

/*
extension UITabBarController {
    override open func viewDidLoad() {
        
        
        let standardAppearance = UITabBarAppearance()
       // standardAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: (UIColor(named: "Mywhite"))!]
      //  standardAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "Mywhite")
       // standardAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: (UIColor(named: "Myblack"))!]
       // standardAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "Myblack")
        tabBar.standardAppearance = standardAppearance
        
    }
}
*/
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
        appearance.largeTitleTextAttributes.updateValue(UIColor.white, forKey: NSAttributedString.Key.foregroundColor)
        //color when the title is small
        appearance.titleTextAttributes.updateValue(UIColor.white, forKey: NSAttributedString.Key.foregroundColor)
        
        // change the background- and title foregroundcolor for navigationbar
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
        // change color of navigationbar items
        navigationBar.tintColor = UIColor.white
    }
}



// Progress Bars and Circle


struct CircleProgress: View {
    var precent : CGFloat = 0
    var colors : [Color] = [Color("Myblue2"),Color("Myblue2")]
    
    var body: some View {
        ZStack{
            
            // expanding
            Image(systemName: "circle.grid.hex.fill")
                .renderingMode(.template)
                .foregroundColor(Color("Myblue2"))
                .font(.headline)
                .padding(.all,10)
                .frame(maxWidth:30,maxHeight: 30)
                .frame(width: 30, height: 30)
                .background(Circle()
                    .stroke(Color("Mygray"),lineWidth: 3)
                    .overlay(Circle()
                        .trim(from: 0, to: precent * 0.01)
                        .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                        .fill(AngularGradient(gradient: .init(colors: colors), center: .center, startAngle: .zero, endAngle: .init(degrees: 360)))
                    )
                                .animation(self.precent != 0 ? .spring(response: 1.0, dampingFraction: 1.0, blendDuration: 1.0) : nil )
            )
            
        }
        
    }
    
    
}



struct BarProgress: View {
    var value: CGFloat = 0
    var colors : [Color] = [Color("Myblue"),Color("Myblue")]
    
    var body: some View {
        ZStack(alignment: .leading){
            Capsule().frame(width:35, height: 5)
                .foregroundColor(Color("Mygray"))
            Capsule().frame(width:value, height: 5)
                .foregroundColor(Color("Myblue2"))
            
        }
        .animation(self.value != 0 ? Animation.easeIn.delay(0.7) : nil)
        
    }
    
}



// Customizing Emoji.
struct EmojiMoodButton: View {
    var colorName: String
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(colorName))
                .shadow(radius: 3)
                .frame(width: 50, height: 50)
            
            Image(colorName)
                .resizable()
                .frame(width: 45, height: 45)
                .scaledToFill()
        }
    }
}
