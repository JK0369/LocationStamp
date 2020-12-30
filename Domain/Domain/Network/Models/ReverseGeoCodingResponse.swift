//
//  ReverseGeoCodingResponse.swift
//  Domain
//
//  Created by 김종권 on 2020/12/31.
//

import Foundation

// MARK: - ReverseGeoCodingResponse
public struct ReverseGeoCodingResponse: Codable {
    public let latitude, longitude: Double
    public let plusCode, localityLanguageRequested, continent, continentCode: String
    public let countryName, countryCode, principalSubdivision, principalSubdivisionCode: String
    public let city, locality, postcode: String
    public let localityInfo: LocalityInfo
}

// MARK: - LocalityInfo
public struct LocalityInfo: Codable {
    public let administrative, informative: [Ative]
}

// MARK: - Ative
public struct Ative: Codable {
    public let order: Int
    public let adminLevel: Int?
    public let name: String
    public let ativeDescription, isoName, isoCode, wikidataID: String?
    public let geonameID: Int?

    public enum CodingKeys: String, CodingKey {
        case order, adminLevel, name
        case ativeDescription = "description"
        case isoName, isoCode
        case wikidataID = "wikidataId"
        case geonameID = "geonameId"
    }
}
