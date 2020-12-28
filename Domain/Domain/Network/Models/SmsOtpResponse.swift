//
//  SmsOtpResponse.swift
//  Domain
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation

public struct SmsOtpResponse: BaseResponsable {
    public let responseCode: Int
    public let message: String
}
