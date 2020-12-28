//
//  PostTaskManager.swift
//  Domain
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
import UIKit

public enum PostTaskType {
    case showToast(message: String)
    case opinion(message: String)
}

public enum PostTaskTarget {
    case profileMain
    case home
    case rating
    case history
}

public struct PostTask {
    let target: PostTaskTarget
    let task: PostTaskType
}

public class PostTaskManager {

    public init() {}

    private var postTasks = [PostTaskTarget: [PostTaskType]]()

    func register(postTask: PostTask) {
        guard postTasks[postTask.target] != nil else {
            postTasks[postTask.target] = [postTask.task]
            return
        }

        postTasks[postTask.target]?.append(postTask.task)
    }

    func postTasks(postTastTarget: PostTaskTarget) -> [PostTaskType]? {
        if isExist(taskTarget: postTastTarget) {
            return postTasks[postTastTarget]
        } else {
            return nil
        }
    }

    func removeAll() {
        postTasks.removeAll()
    }

    func remove(for input: PostTaskTarget) {
        postTasks[input]?.removeAll()
    }

    private func isExist(taskTarget: PostTaskTarget) -> Bool {
        return !(postTasks[taskTarget]?.isEmpty ?? true)
    }
}
