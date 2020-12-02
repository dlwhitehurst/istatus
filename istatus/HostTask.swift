//
//  HostTask.swift
//  istatus
//
//  Created by David Whitehurst on 12/2/20.
//

import Foundation

struct HostTask: Identifiable {
    let id = UUID()
    let date = Date()
    let proto: String
    let hostname: String
    let port: String
    let path: String
    let task: String // e.g. http2xx for now
}

extension HostTask {
    func build() -> String {
        return proto + "://" + hostname + ":" + port + "/" + path
    }
}
