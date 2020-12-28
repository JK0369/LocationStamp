//
//  KeyValueStore.swift
//  Domain
//
//  Created by 김종권 on 2020/12/27.
//

import Foundation

public protocol KeyValueStore {
    func save(key: String, value: String)
    func get(key: String) -> String?
    func delete(key: String)
    func removeAll()
}

public extension KeyValueStore {

    func getName() -> String {
        return get(key: Constants.KeychainKey.name) ?? ""
    }

    func deleteUserInfo() {
        delete(key: Constants.KeychainKey.name)
    }
}
