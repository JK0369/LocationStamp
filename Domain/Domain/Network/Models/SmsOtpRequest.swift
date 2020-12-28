//
//  SmsOtpRequest.swift
//  Domain
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation
public struct SmsOtpRequest: Codable {
    public let serviceMemberID: String?
    public let mobilePhoneNumber, internationalCallingCountryNumber: String

    enum CodingKeys: String, CodingKey {
        case serviceMemberID = "serviceMemberId"
        case mobilePhoneNumber, internationalCallingCountryNumber
    }

    public init(serviceMemberID: String?, mobilePhoneNumber: String, internationalCallingCountryNumber: String) {
        self.serviceMemberID = serviceMemberID
        self.mobilePhoneNumber = mobilePhoneNumber
        self.internationalCallingCountryNumber = internationalCallingCountryNumber
    }
}
