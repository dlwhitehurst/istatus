//
//  VpnView.swift
//  istatus
//
//  Created by David Whitehurst on 12/3/20.
//

import SwiftUI

struct VpnView: View {
//    var body: some View {
//        Text("VpnView")
//    }
    @State var platforms = ["Ninetendo", "XBox", "PlayStation",
                            "Maya Lou Whitehurst","Bailey Jane Whitehurst","Patricia Rigler Whitehurst","David Lee Whitehurst","Nancy Burch","Wendy Price",
                            "PlayStation 2", "PlayStation 3", "PlayStation 4"]

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.platforms, id: \.self) { platform in
                self.item(for: platform)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if platform == self.platforms.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if platform == self.platforms.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    func item(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
            .font(.body)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }
    
}

struct VpnView_Previews: PreviewProvider {
    static var previews: some View {
        VpnView()
    }
}
