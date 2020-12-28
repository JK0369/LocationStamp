//
//  Encodable.swift
//  Isetan
//
//  Created by Kaung Soe on 3/22/19.
//

import Foundation

public extension Encodable {
    
    func toDictionary() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let dic =  try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dic ?? [:]
            
        } catch {
            return [:]
        }
    }
}

public func toJSONString<T: Encodable>(_ encodable: T) -> String? {
    let encData = try? JSONEncoder().encode(encodable)
    return encData.flatMap { String(data: $0, encoding: .utf8) }
}
