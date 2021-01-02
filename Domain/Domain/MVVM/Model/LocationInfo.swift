//
//  LocationInfo.swift
//  Domain
//
//  Created by 김종권 on 2021/01/02.
//

import Foundation

public struct LocationInfo {
    public let pricipalSubdivision: String
    public let city: String
    public let locality: String
    public let lat: Double
    public let lng: Double

    public init(pricipalSubdivision: String, city: String, locality: String, lat: Double, lng: Double) {
        self.pricipalSubdivision = pricipalSubdivision
        self.city = city
        self.locality = locality
        self.lat = lat
        self.lng = lng
    }

    public func location() -> String {
        pricipalSubdivision + " " + city + " " + locality
    }
}
