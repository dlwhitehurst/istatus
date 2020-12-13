//
//  DashView.swift
//  istatus
//
//  Created by David Whitehurst on 12/3/20.
//

import SwiftUI

struct DashView {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Monitor.entity(), sortDescriptors:
                    [NSSortDescriptor(keyPath: \Monitor.date, ascending: true)])
    var monitors: FetchedResults<Monitor>
}

extension DashView: View {
    var body: some View {
        VStack {
            // Heading
            Text("iStatus Monitor Events")
            .font(.largeTitle)
            .padding()
            
            // Special Stack
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
            .padding(.bottom)
            
            // Refresh Button
            Button(action: {
                Runner(monitors: monitors, viewContext: viewContext).run()
            }) {
                Text("Refresh")
            }
            .padding()
            
            // Alignment spacer
            Spacer()
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.monitors, id: \.self) { monitor in
                self.item(for: monitor)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if monitor == self.monitors.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if monitor == self.monitors.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
    
    func getColor(monitor: Monitor) -> Color {
        if (monitor.status) {
            return Color.green
        } else {
            return Color.red
        }
    }
    
    func item(for monitor: Monitor) -> some View {
        Button(action: {
            print("Button clicked")
        }) {
            VStack {
                Text(monitor.hostname!)
                    .padding(.top)
                    .padding(.horizontal, 10)
                    .font(.title)
                Text(monitor.task!)
                    .font(.caption)
                    .padding(.bottom)
              }
              .background(getColor(monitor: monitor))
              .foregroundColor(Color.white)
            }
            .cornerRadius(20)
    }

}

struct DashView_Previews: PreviewProvider {
    static var previews: some View {
        DashView()
    }
}
