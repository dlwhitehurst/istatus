//
//  CheckTaskPicker.swift
//  istatus
//
//  Created by David Whitehurst on 12/3/20.
//

import SwiftUI

struct CheckTaskPicker {
    // no initialization
}

extension CheckTaskPicker: View {
    var body: some View {
        Picker(selection: .constant(1), label: Text("Task")) {
            
            Text("http2xx").tag(1)
            Text("httpContains").tag(2)
            Text("jdbc-connect").tag(3)
            Text("telnet-port").tag(4)
        }
        .pickerStyle(SegmentedPickerStyle())
        .frame(width: 400, height: 30)
    }
}

struct CheckTaskPicker_Previews: PreviewProvider {
    static var previews: some View {
        CheckTaskPicker()
    }
}
