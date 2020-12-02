//
//  HostTasks.swift
//  istatus
//
//  Created by David Whitehurst on 12/2/20.
//

import Foundation

class HostTasks: ObservableObject {
  @Published private(set) var tasks = [HostTask]() {
    didSet {
      print(tasks)
    }
  }
}

extension HostTasks {
    func add(_ task: HostTask) {
        tasks.insert(task, at: 0)
    }
    
    func get(_ index: Int) -> HostTask {
        return tasks[index]
    }

    func remove(_ indexSet: IndexSet) { _ = indexSet.map{index in
    tasks.remove(at: index) }
    }
    
    func clear() {
        tasks.removeAll()
    }
}
