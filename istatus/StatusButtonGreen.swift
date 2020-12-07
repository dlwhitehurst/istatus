//
//  StatusButtonGreen.swift
//  istatus
//
//  Created by David Whitehurst on 12/6/20.
//

import SwiftUI

struct StatusButtonGreen {
}

extension StatusButtonGreen: View {
    var body: some View {
        Button(action: {
            print("under construction")
        }) {
            VStack {
                Text("192.168.117.155")
                    .padding(.top)
                    .padding(.horizontal, 10)
                    .font(.title)
                Text("http-status")
                    .font(.caption)
                    .padding(.bottom)
             }
             .background(Color.green)
             .foregroundColor(Color.white)
        }
        .cornerRadius(20)
    }
}

struct StatusButtonGreen_Previews: PreviewProvider {
    static var previews: some View {
        StatusButtonGreen()
    }
}
