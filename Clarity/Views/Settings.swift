//
//  SwiftUIView.swift
//  life
//
//  Created by Nawaf Almutairi on 6/29/20.
//  Copyright © 2020 Nawaf Almutairi. All rights reserved.
//

import SwiftUI



struct Profile: View {
    
    
    @FetchRequest(entity: Mood.entity(), sortDescriptors: [NSSortDescriptor(key: "decodedDate", ascending: false)])
    var moods: FetchedResults<Mood>
    
    @State var settings = [NSLocalizedString("Backup to iCloud", comment: ""),NSLocalizedString("Privacy & Security", comment: ""),
                           NSLocalizedString("Langague - اللغة", comment: "")]
        
    @State var icons = ["icloud","hand.raised","globe"]
    @ObservedObject var userSettings = UserSettings()
    
    @State var icloudFlag : Bool = false
    @State var privacyFlag : Bool = false
    @State var langaugeFlag : Bool = false
    @State var selectedLangaugeToggle = UserDefaults.standard.bool(forKey: "languageToggle")
    @State var selectedLangauge = UserDefaults.standard.string(forKey: "language")
    @Namespace var name

    
    private var columns: [GridItem] = [
            GridItem(.fixed(150)),
            GridItem(.fixed(150)),
        ]
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            VStack {
                VStack() {
                    Text("TOTAL CHECK IN")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(Color("Myblue"))
                    Text("\(moods.count)")
                        .font(.system(size: 18))
                        .bold()

                    
                }
                .background(Color.white)
                .padding(.top)


                
                Divider()
                    LazyVGrid(
                                    columns: columns,
                                    alignment: .center,
                                    spacing: 25
                    ) {
                        ForEach(settings.indices, id: \.self) { index in
                            VStack(spacing:10) {
                                Image(systemName: icons[index])
                                    .font(.title)
                                Text(settings[index])
                            }
                            .frame(width: 150, height: 175, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color("Myblue"))
                            .cornerRadius(20)
                            
                            .onTapGesture {
                                switch index {
                                case 0:
                                    self.icloudFlag = true
                                case 1:
                                    self.privacyFlag = true
                                case 2:
                                    self.langaugeFlag = true
                                case 3:
                                    self.langaugeFlag = true
                                default:
                                    break;
                                }
                            }
                            
                        }.shadow(radius: 1,y: 3)
                    }.padding()
                Spacer()
                    Divider()
                VStack(spacing:15) {
                    HStack(spacing:20) {
                        
                        Link(destination: URL(string: "https://www.instagram.com/claritymind.co")!) {
                            Image("IGicon")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                        }
                        
                        Link(destination: URL(string: "https://www.claritymind.co")!) {
                            Image(systemName: "globe")
                                .resizable()
                                .font(Font.title.weight(.light))
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(.blue)
                        }
                    
                       
                        
                    }
                    .padding(.bottom,80)
                }
                .padding(.bottom)
            
              
                
                
    }
            
            /*.alert(isPresented: $langaugeFlag) {
                 Alert (title: Text("Camera access required to take photos"),
                        message: Text("Go to Settings?"),
                        primaryButton: .default(Text("Settings"), action: {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        }),
                        secondaryButton: .default(Text("Cancel")))
                    }*/

        
            if icloudFlag {
                Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
                    .scaleEffect()
                    .onTapGesture {
                        self.icloudFlag.toggle()
                    }
                
                VStack {
                    
                    HStack {
                        Spacer()
                        Text("Backup to iCloud")
                            .foregroundColor(Color.white)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    .padding(.horizontal,5)
                    .background(Color("Myblue"))
                    
                    VStack {
                        Toggle(isOn: $userSettings.iCloud) {
                            Text("iCloud")
                                
                        }
                        .onChange(of: userSettings.iCloud) { value in
                            CoreDataManager.shared.refreshCoreDataContainer()
                    }
                        
                        
                        Divider()
                        
                        Text("Storing your enteries in iCloud keeps them up-to-date across all of your devices. If you delete an entry, it will be deleted from iCloud and your devices.")
                            .font(.subheadline)
                        
                       
                        
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(Color.yellow)
                            .font(.title)
                            .padding(.top)
                        
                        Text("Please don't share your iCloud account so your journals and entries won't be seen by others.")
                            .font(.subheadline)
                            .underline()
                            .multilineTextAlignment(.center)
                            
                        Spacer()
                        
                    }
                    .padding()
                    
                    
                    Spacer()
                }.frame(width:UIScreen.main.bounds.width,height: 400)
                    .background(Color.primary.colorInvert()).cornerRadius(50)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
                    .zIndex(0)
                
                
            }
            
            if privacyFlag {
                
                
                Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
                    .scaleEffect()
                    .onTapGesture {
                        self.privacyFlag.toggle()
                    }
                
                
                VStack {
                    HStack {
                        Spacer()
                        Text("Privacy & Security")
                            .foregroundColor(Color.white)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    .padding(.horizontal,5)
                .background(Color("Myblue"))
                    
                    
                    VStack {
                        
                        Text("Clarity takes privacy very serious.")
                            .bold()

                        Text("• No content, including journal entries and any activity will be saved, tracked or even backed up in our servers. \n• We provide CloudKit so you can easily backup your data easily and securely using your iCloud Account")
                            .font(.subheadline)
                            .padding(.top,2)
                        
                        Text("Clarity will never have access to your data.")
                            .font(.subheadline)
                            .bold()
                            .underline()
                            .multilineTextAlignment(.center)
                            .padding(.top)
                        
                    }.padding()
                    
                    
                    Spacer()
                }
                .frame(width:UIScreen.main.bounds.width,height: 400)
                    .background(Color.primary.colorInvert()).cornerRadius(50)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
                    .zIndex(0)
                
            }
            
            if langaugeFlag {
                
                Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all)
                    .scaleEffect()
                    .onTapGesture {
                        self.langaugeFlag.toggle()
                    }
                
                
                VStack {
                    HStack {
                        Spacer()
                        Text("Langauge - اللغة")
                            .foregroundColor(Color.white)
                            .bold()
                        Spacer()
                    }
                    .padding()
                    .padding(.horizontal,5)
                .background(Color("Myblue"))
                    
                    
                    VStack {
                        GifImage("langaugeGIF")
                            .frame(width: 250,height:200)
                            .shadow(radius: 5)
                            //.offset(y:-10)
                            //.padding(.horizontal)
                        
                        Button(action: {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        }) {
                            Text("Settings - الإعدادات")
                                .font(.footnote)
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                                .background(Color("Myblue"))
                                .cornerRadius(20)
                                .shadow(radius: 3)
                        }

                        
                    }
                    
                    Spacer()
                }
                .frame(width:UIScreen.main.bounds.width,height: 450)
                    .background(Color.primary.colorInvert()).cornerRadius(50)
                    .transition(.move(edge: .bottom))
                    .animation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 1.0))
                    .zIndex(0)
                
            }
            
            
        
    }
        .edgesIgnoringSafeArea(.bottom)
        .multilineTextAlignment(.center)

        
    }
    
}



struct Profile_Preview: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}


