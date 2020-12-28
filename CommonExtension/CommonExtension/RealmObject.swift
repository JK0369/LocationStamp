//
//  RealmObject.swift
//  Isetan
//
//  Created by Kaung Soe on 5/20/19.
//  Copyright © 2019 codigo. All rights reserved.
//
/*
import Foundation
import RealmSwift

extension Object {
    
    static func save<T: Object>(_ object: T) {
        do {
            let realm = try Realm(configuration: Realm.safeConfig)
            try realm.write {
                realm.delete(realm.objects(T.self))
                realm.add(object)
            }
        } catch {
            log.debug(error)
        }
    }
    
    static func getData<T: Object>() -> T? {
        do {
            let realm = try Realm(configuration: Realm.safeConfig)
            return realm.objects(T.self).first
        } catch {
            log.debug(error)
            return nil
        }
    }

}

extension List {
    func toArray() -> [Element] {
        return Array(self)
    }
}
*/
