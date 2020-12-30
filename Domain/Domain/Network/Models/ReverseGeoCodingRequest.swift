//
//  ReverseGeoCodingRequest.swift
//  Domain
//
//  Created by 김종권 on 2020/12/31.
//

import Foundation

public struct ReverseGeoCodingRequest: Codable {
    let latitude: Double
    let longitude: Double
    let localityLanguage: String

    public init(latitude: Double, longitude: Double, localityLanguage: String = "ko") {
        self.latitude = latitude
        self.longitude = longitude
        self.localityLanguage = localityLanguage
    }
}

//latitude=37.42159&longitude=-122.0837&localityLanguage=ko
