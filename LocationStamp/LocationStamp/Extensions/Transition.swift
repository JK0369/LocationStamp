//
//  Transition.swift
//  TapRider
//
//  Created by 김종권 on 2020/10/16.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation
import XCoordinator

extension Transition {
    static func addChild(_ child: Presentable) -> Transition {
        Transition(presentables: [child], animationInUse: nil) { _, _, completion in
            completion?()
        }
    }
}
