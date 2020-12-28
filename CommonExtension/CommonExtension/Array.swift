//
//  Array.swift
//
//
//  Created by KaungSoe on 6/19/18.
//  Copyright © 2018 Codigo. All rights reserved.
//

import Foundation

public extension Array {
    
    func mapTo<T>(_ value: T) -> [T] {
        map { _ in value }
    }
    
    mutating func appendAndGetIndexPath(_ elements: [Element]) -> [IndexPath] {
        let currentLastIndex = count
        append(contentsOf: elements)
        let newIndexs = elements
            .enumerated()
            .map { index, _ in IndexPath(item: currentLastIndex + index, section: 0) }
        return newIndexs
    }
}

public extension Array where Element == String? {
    
    var combined: String {
        return self.reduce("") {
            ($0) + " " + ($1 ?? "")
        }.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
    
    func combined(withSeperator: String) -> String {
        return self.reduce("") {
            ($0) + "\(withSeperator)" + ($1 ?? "")
            }.trimmingCharacters(in: CharacterSet(charactersIn: withSeperator))
    }
}

public extension Array where Element == Int {
    
    func joined(withSeperator: String) -> String {
        let result = (self.reduce("") { first, last in
            ("\(first)") + "\(withSeperator)" + ("\(last)" )
            }.trimmingCharacters(in: CharacterSet(charactersIn: withSeperator)))
        return result

    }
}

public func rearrange<T>(array: [T], fromIndex: Int, toIndex: Int) -> [T] {
    var arr = array
    let element = arr.remove(at: fromIndex)
    arr.insert(element, at: toIndex)
    
    return arr
}

public extension RangeReplaceableCollection where Indices: Equatable {
    mutating func rearrange(from: Index, to: Index) {
        precondition(from != to && indices.contains(from) && indices.contains(to), "invalid indices")
        insert(remove(at: from), at: to)
    }
}
