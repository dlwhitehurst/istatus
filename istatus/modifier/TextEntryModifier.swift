//
//  TextEntryModifier.swift
//  istatus
//
//  Created by David Whitehurst on 12/2/20.
//

import SwiftUI

struct TextEntryModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .autocapitalization(.none)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}
