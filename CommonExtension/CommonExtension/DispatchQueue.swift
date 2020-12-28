//
//  DispatchQueue.swift
//  Isetan
//
//  Created by Kaung Soe on 5/21/19.
//  Copyright © 2019 codigo. All rights reserved.
//

import Foundation

public func delay(_ sec: Double, execute:@escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: (.now() + sec), execute: execute)
}

public func onMainThread(execute:@escaping () -> Void) {
    DispatchQueue.main.async(execute: execute)
}
