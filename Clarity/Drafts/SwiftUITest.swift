
import SwiftUI

struct PieChartCell: Shape {
    let startAngle: Angle
    let endAngle: Angle
   func path(in rect: CGRect) -> Path {
        let center = CGPoint.init(x: (rect.origin.x + rect.width)/2, y: (rect.origin.y + rect.height)/2)
    let radii = min(center.x, center.y)
        let path = Path { p in
            p.addArc(center: center,
                     radius: radii,
                     startAngle: startAngle,
                     endAngle: endAngle,
                     clockwise: true)
            p.addLine(to: center)
        }
        return path
   }
}

struct InnerCircle: Shape {
    let ratio: CGFloat
    func path(in rect: CGRect) -> Path {
         let center = CGPoint.init(x: (rect.origin.x + rect.width)/2, y: (rect.origin.y + rect.height)/2)
        let radii = min(center.x, center.y) * ratio
         let path = Path { p in
             p.addArc(center: center,
                      radius: radii,
                      startAngle: Angle(degrees: 0),
                      endAngle: Angle(degrees: 360),
                      clockwise: true)
             p.addLine(to: center)
         }
         return path
    }
}


struct PieChart: View {
    @State private var selectedCell: UUID = UUID()
    
    let dataModel: ChartDataModel
    let onTap: (ChartCellModel?) -> ()
    var body: some View {
            ZStack {
                ForEach(dataModel.chartCellModel) { dataSet in
                    PieChartCell(startAngle: self.dataModel.angle(for: dataSet.value), endAngle: self.dataModel.startingAngle)
                        .foregroundColor(dataSet.color)
                       .onTapGesture {
                         withAnimation {
                            if self.selectedCell == dataSet.id {
                                self.onTap(nil)
                                self.selectedCell = UUID()
                            } else {
                                self.selectedCell = dataSet.id
                                self.onTap(dataSet)
                            }
                        }
                    }.scaleEffect((self.selectedCell == dataSet.id) ? 1.05 : 1.0)
                }
            }
    }
}



struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
}


struct ContentView: View {
    
    // Arrays start here.
    @State var moodArray =
        ["Wonderful","Excited","Happy",
        "Calm","I don't know","Stressed",
        "Bored","Lonely","Tired",
        "Overwhelmed","Anxious"]
    
    @State var addItem = ""
    
    
    var columns = [GridItem(.flexible(), spacing: 0),
                   GridItem(.flexible(), spacing: 0),
                   GridItem(.flexible(), spacing: 0)]
 
        var body: some View {
            
            
            CustomTextField(
                placeholder: Text("placeholder").foregroundColor(.white.opacity(0.5)),
                        text: $addItem
                    )
                            .padding()
                            .background(Color("Myblue"))
                            .cornerRadius(20)
                            .padding(.horizontal)
            
            
//            TextField("Add More", text: $addItem)
//                .accentColor(Color.white)
//                .padding()
//                .background(Color("Myblue"))
//                .cornerRadius(20)
//                .padding(.horizontal)
            
            
        }
    
    
    
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ChartCellModel: Identifiable {
    let id = UUID()
    let color: Color
    let value: CGFloat
    let name: String
}

final class ChartDataModel: ObservableObject {
    var chartCellModel: [ChartCellModel]
    var startingAngle = Angle(degrees: 0)
    private var lastBarEndAngle = Angle(degrees: 0)
    
        
    init(dataModel: [ChartCellModel]) {
        chartCellModel = dataModel
    }
    
    var totalValue: CGFloat {
        chartCellModel.reduce(CGFloat(0)) { (result, data) -> CGFloat in
            result + data.value
        }
    }
    
    func angle(for value: CGFloat) -> Angle {
        if startingAngle != lastBarEndAngle {
            startingAngle = lastBarEndAngle
        }
        lastBarEndAngle += Angle(degrees: Double(value / totalValue) * 360 )
        print(lastBarEndAngle.degrees)
        return lastBarEndAngle
    }
}

