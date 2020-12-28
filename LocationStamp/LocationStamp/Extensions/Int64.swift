//
//  Int64.swift
//  CommonExtension
//
//  Created by Codigo Sheilar on 25/05/2020.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation


extension Int64 {
    
    func toHourMinute() -> String {
        let hr = self / 3600
        let min = (self % 3600) / 60
        return "\(hr) 시간 \(min) 분"
    }
}
