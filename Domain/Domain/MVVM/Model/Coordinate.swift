//
//  Coordinate.swift
//  Domain
//
//  Created by 김종권 on 2021/01/02.
//

import Foundation

public struct Coordinate {
    public let lat: Double
    public let lng: Double
    public init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
}
