//
//  DetailTextDisplay.swift
//  istatus
//
//  Created by David Whitehurst on 12/3/20.
//

import SwiftUI

struct DetailTextDisplay {
    let value: String
}

extension DetailTextDisplay: View {
    var body: some View {
        Text(value)
            .font(.footnote)
            .fontWeight(.light)
            .padding()
    }
}
