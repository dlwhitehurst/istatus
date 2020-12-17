//
//  LabelTextDisplay.swift
//  istatus
//
//  Created by David Whitehurst on 12/3/20.
//

import SwiftUI

struct LabelTextDisplay {
    let value: String
}

extension LabelTextDisplay: View {
    var body: some View {
        Text(value)
            .fontWeight(.heavy)
            .foregroundColor(Color.blue)
            .padding(.leading)
    }
}

