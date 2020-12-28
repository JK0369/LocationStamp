//
//  Data.swift
//  CommonExtension
//
//  Created by Codigo Kaung Soe on 03/03/2020.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation

public extension Data {
    
    static func generateRandom() -> Data {
        var keyData = Data(count: 64)
        _ = keyData.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, 64, $0.baseAddress!)
        }
        return keyData
    }
    
    var getMB: String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useMB]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(count))
    }
}
