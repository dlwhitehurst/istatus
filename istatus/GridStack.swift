//
//  GridStack.swift
//  istatus
//
//  Created by David Whitehurst on 12/6/20.
//

import SwiftUI

struct GridStack<Content: View>: View { let rows: Int
let columns: Int
let content: (Int, Int) -> Content
    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content }
    }

struct GridStack_Previews: PreviewProvider {
    static var previews: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            Button(action: {
            print("under construction")
        }) {
                VStack {
            Text("192.168.1.1")
                .padding(.top)
            .padding(.horizontal, 10)
            .font(.body)
            .background(Color.green)
            .foregroundColor(Color.white)
            
            Text("http-status")
                .font(.caption)
                .foregroundColor(Color.white)
                .padding(.bottom)
                }
                .background(Color.green)
                .cornerRadius(10)
            }
        }
    }
}
