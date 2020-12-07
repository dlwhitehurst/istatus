//
//  StatusButtonRed.swift
//  istatus
//
//  Created by David Whitehurst on 12/6/20.
//

import SwiftUI

struct StatusButtonRed {
}

extension StatusButtonRed: View {
    var body: some View {
        Button(action: {
            print("under construction")
        }) {
            VStack {
                Text("acme.com")
                    .padding(.top)
                    .padding(.horizontal, 10)
                    .font(.title)
                Text("http-status")
                    .font(.caption)
                    .padding(.bottom)
             }
             .background(Color.red)
             .foregroundColor(Color.white)
        }
        .cornerRadius(20)
    }
}

struct StatusButtonRed_Previews: PreviewProvider {
    static var previews: some View {
        StatusButtonRed()
    }
}
