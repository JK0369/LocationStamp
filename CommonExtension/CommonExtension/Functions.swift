//
//  public functions.swift
//  CommonExtension
//
//  Created by Codigo Kaung Soe on 09/04/2020.
//  Copyright © 2020 42dot. All rights reserved.
//

import Foundation

precedencegroup ForwardApplication {
    associativity: left
}

precedencegroup SingleComposition {
    associativity: right
    higherThan: ForwardApplication
}

precedencegroup ForwardComposition {
    associativity: right
    higherThan: ForwardApplication
}

infix operator <>: SingleComposition
infix operator |>: ForwardApplication
infix operator >>>: ForwardComposition
infix operator <*>: AdditionPrecedence

public func map <A, B>(_ f:@escaping (A) -> B) -> ([A]) -> [B] {
    return {
        $0.map(f)
    }
}

public func logging<T>(_ message: String = "") -> (_ any: T) -> Void {
    return {
        
        // TODO: sheilar
        print("\($0) \(message)")
        // Current.log.debug("\($0) \(message)")
    }
}

public func id<A>(_ x: A) -> A {
    x
}

public func constant<A, B>(_ x: B) -> (A) -> B {
    return { _ in
        x
    }
}

public func <> <A: AnyObject>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> (A) -> Void {
    return { a in
        f(a)
        g(a)
    }
}

public func |> <A, B>(x: A, f: (A) -> B) -> B {
    return f(x)
}

public func >>> <A, B, C>(_ f:@escaping (A) -> B, g:@escaping (B) -> C) -> (A) -> C {
    return {
        g(f($0))
    }
}

public func flip <A, B, C>(_ f: @escaping (A) -> (B) -> C)
    -> (B) -> (A) -> C {
        return { (b: B) -> (A) -> C in { (a: A) -> C in
                f(a)(b)
            }
        }
}

public func zurry <A>(_ f: () -> A) -> A {
    return f()
}

//public func curry <A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
//    return { a in
//        return { b in
//            f(a, b)
//        }
//    }
//}

public func curry <A1, A2, R> (_ function: @escaping (A1, A2) -> R) -> (A1) -> (A2) -> R {
   return { (a1: A1) -> (A2) -> R in { (a2: A2) -> R in function(a1, a2) } }
}

public func curry <A1, A2, R> (_ function: @escaping (A1, A2) throws -> R) -> (A1) -> (A2) throws -> R {
   return { (a1: A1) -> (A2) throws -> R in { (a2: A2) throws -> R in try function(a1, a2) } }
}

public func curry <A1, A2, A3, R> (_ function: @escaping (A1, A2, A3) -> R) -> (A1) -> (A2) -> (A3) -> R {
   return { (a1: A1) -> (A2) -> (A3) -> R in { (a2: A2) -> (A3) -> R in { (a3: A3) -> R in function(a1, a2, a3) } } }
}

public func curry <A1, A2, A3, R> (_ function: @escaping (A1, A2, A3) throws -> R) -> (A1) -> (A2) -> (A3) throws -> R {
   return { (a1: A1) -> (A2) -> (A3) throws -> R in { (a2: A2) -> (A3) throws -> R in { (a3: A3) throws -> R in try function(a1, a2, a3) } } }
}

public func curry <A1, A2, A3, A4, R> (_ function: @escaping (A1, A2, A3, A4) -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> R in { (a2: A2) -> (A3) -> (A4) -> R in { (a3: A3) -> (A4) -> R in { (a4: A4) -> R in function(a1, a2, a3, a4) } } } }
}

public func curry <A1, A2, A3, A4, R> (_ function: @escaping (A1, A2, A3, A4) throws -> R) -> (A1) -> (A2) -> (A3) -> (A4) throws -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) throws -> R in { (a2: A2) -> (A3) -> (A4) throws -> R in { (a3: A3) -> (A4) throws -> R in { (a4: A4) throws -> R in try function(a1, a2, a3, a4) } } } }
}

public func curry <A1, A2, A3, A4, A5, R> (_ function: @escaping (A1, A2, A3, A4, A5) -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> R in { (a3: A3) -> (A4) -> (A5) -> R in { (a4: A4) -> (A5) -> R in { (a5: A5) -> R in function(a1, a2, a3, a4, a5) } } } } }
}

public func curry <A1, A2, A3, A4, A5, R> (_ function: @escaping (A1, A2, A3, A4, A5) throws -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) throws -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) throws -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) throws -> R in { (a3: A3) -> (A4) -> (A5) throws -> R in { (a4: A4) -> (A5) throws -> R in { (a5: A5) throws -> R in try function(a1, a2, a3, a4, a5) } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6) -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> R in { (a4: A4) -> (A5) -> (A6) -> R in { (a5: A5) -> (A6) -> R in { (a6: A6) -> R in function(a1, a2, a3, a4, a5, a6) } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6) throws -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) throws -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) throws -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) throws -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) throws -> R in { (a4: A4) -> (A5) -> (A6) throws -> R in { (a5: A5) -> (A6) throws -> R in { (a6: A6) throws -> R in try function(a1, a2, a3, a4, a5, a6) } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7) -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) -> R in { (a5: A5) -> (A6) -> (A7) -> R in { (a6: A6) -> (A7) -> R in { (a7: A7) -> R in function(a1, a2, a3, a4, a5, a6, a7) } } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7) throws -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) throws -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) throws -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) throws -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) throws -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) throws -> R in { (a5: A5) -> (A6) -> (A7) throws -> R in { (a6: A6) -> (A7) throws -> R in { (a7: A7) throws -> R in try function(a1, a2, a3, a4, a5, a6, a7) } } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, A8, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7, A8) -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) -> (A8) -> R in { (a5: A5) -> (A6) -> (A7) -> (A8) -> R in { (a6: A6) -> (A7) -> (A8) -> R in { (a7: A7) -> (A8) -> R in { (a8: A8) -> R in function(a1, a2, a3, a4, a5, a6, a7, a8) } } } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, A8, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7, A8) throws -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) throws -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) throws -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) throws -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) throws -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) -> (A8) throws -> R in { (a5: A5) -> (A6) -> (A7) -> (A8) throws -> R in { (a6: A6) -> (A7) -> (A8) throws -> R in { (a7: A7) -> (A8) throws -> R in { (a8: A8) throws -> R in try function(a1, a2, a3, a4, a5, a6, a7, a8) } } } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, A8, A9, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7, A8, A9) -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> R in { (a5: A5) -> (A6) -> (A7) -> (A8) -> (A9) -> R in { (a6: A6) -> (A7) -> (A8) -> (A9) -> R in { (a7: A7) -> (A8) -> (A9) -> R in { (a8: A8) -> (A9) -> R in { (a9: A9) -> R in function(a1, a2, a3, a4, a5, a6, a7, a8, a9) } } } } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, A8, A9, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7, A8, A9) throws -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) throws -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) throws -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) throws -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) throws -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) throws -> R in { (a5: A5) -> (A6) -> (A7) -> (A8) -> (A9) throws -> R in { (a6: A6) -> (A7) -> (A8) -> (A9) throws -> R in { (a7: A7) -> (A8) -> (A9) throws -> R in { (a8: A8) -> (A9) throws -> R in { (a9: A9) throws -> R in try function(a1, a2, a3, a4, a5, a6, a7, a8, a9) } } } } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10) -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> R in { (a5: A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> R in { (a6: A6) -> (A7) -> (A8) -> (A9) -> (A10) -> R in { (a7: A7) -> (A8) -> (A9) -> (A10) -> R in { (a8: A8) -> (A9) -> (A10) -> R in { (a9: A9) -> (A10) -> R in { (a10: A10) -> R in function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10) } } } } } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10) throws -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) throws -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) throws -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) throws -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) throws -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) throws -> R in { (a5: A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) throws -> R in { (a6: A6) -> (A7) -> (A8) -> (A9) -> (A10) throws -> R in { (a7: A7) -> (A8) -> (A9) -> (A10) throws -> R in { (a8: A8) -> (A9) -> (A10) throws -> R in { (a9: A9) -> (A10) throws -> R in { (a10: A10) throws -> R in try function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10) } } } } } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11) -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> R in { (a5: A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> R in { (a6: A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> R in { (a7: A7) -> (A8) -> (A9) -> (A10) -> (A11) -> R in { (a8: A8) -> (A9) -> (A10) -> (A11) -> R in { (a9: A9) -> (A10) -> (A11) -> R in { (a10: A10) -> (A11) -> R in { (a11: A11) -> R in function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11) } } } } } } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11) throws -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) throws -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) throws -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) throws -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) throws -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) throws -> R in { (a5: A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) throws -> R in { (a6: A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) throws -> R in { (a7: A7) -> (A8) -> (A9) -> (A10) -> (A11) throws -> R in { (a8: A8) -> (A9) -> (A10) -> (A11) throws -> R in { (a9: A9) -> (A10) -> (A11) throws -> R in { (a10: A10) -> (A11) throws -> R in { (a11: A11) throws -> R in try function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11) } } } } } } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12) -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) -> R in { (a5: A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) -> R in { (a6: A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) -> R in { (a7: A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) -> R in { (a8: A8) -> (A9) -> (A10) -> (A11) -> (A12) -> R in { (a9: A9) -> (A10) -> (A11) -> (A12) -> R in { (a10: A10) -> (A11) -> (A12) -> R in { (a11: A11) -> (A12) -> R in { (a12: A12) -> R in function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12) } } } } } } } } } } } }
}

public func curry <A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, R> (_ function: @escaping (A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12) throws -> R) -> (A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) throws -> R {
   return { (a1: A1) -> (A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) throws -> R in { (a2: A2) -> (A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) throws -> R in { (a3: A3) -> (A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) throws -> R in { (a4: A4) -> (A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) throws -> R in { (a5: A5) -> (A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) throws -> R in { (a6: A6) -> (A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) throws -> R in { (a7: A7) -> (A8) -> (A9) -> (A10) -> (A11) -> (A12) throws -> R in { (a8: A8) -> (A9) -> (A10) -> (A11) -> (A12) throws -> R in { (a9: A9) -> (A10) -> (A11) -> (A12) throws -> R in { (a10: A10) -> (A11) -> (A12) throws -> R in { (a11: A11) -> (A12) throws -> R in { (a12: A12) throws -> R in try function(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12) } } } } } } } } } } } }
}

public func f1<A>(_ a: A) -> (A) {
    (a)
}

public func f2<A, B>(_ a: A, _ b: B) -> (A, B) {
    (a, b)
}

public func f3<A, B, C>(_ a: A, _ b: B, _ c: C) -> (A, B, C) {
    (a, b, c)
}

public func f4<A, B, C, D>(_ a: A, _ b: B, _ c: C, _ d: D) -> (A, B, C, D) {
    (a, b, c, d)
}

public func f5<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) -> (A, B, C, D, E) {
    (a, b, c, d, e)
}

public func f6<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F) -> (A, B, C, D, E, F) {
    (a, b, c, d, e, f)
}

public func f7<A, B, C, D, E, F, G>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G) -> (A, B, C, D, E, F, G) {
    (a, b, c, d, e, f, g)
}

public func f8<A, B, C, D, E, F, G, H>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H) -> (A, B, C, D, E, F, G, H) {
    (a, b, c, d, e, f, g, h)
}

public func f9<A, B, C, D, E, F, G, H, I>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I) -> (A, B, C, D, E, F, G, H, I) {
    (a, b, c, d, e, f, g, h, i)
}

public func f10<A, B, C, D, E, F, G, H, I, J>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I, _ j: J) -> (A, B, C, D, E, F, G, H, I, J) {
    (a, b, c, d, e, f, g, h, i, j)
}

public func f10<A, B, C, D, E, F, G, H, I, J, K>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I, _ j: J, _ k: K) -> (A, B, C, D, E, F, G, H, I, J, K) {
    (a, b, c, d, e, f, g, h, i, j, k)
}

public func f11<A, B, C, D, E, F, G, H, I, J, K, L>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I, _ j: J, _ k: K, _ l: L) -> (A, B, C, D, E, F, G, H, I, J, K, L) {
    (a, b, c, d, e, f, g, h, i, j, k, l)
}

public func f12<A, B, C, D, E, F, G, H, I, J, K, L, M>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, _ f: F, _ g: G, _ h: H, _ i: I, _ j: J, _ k: K, _ l: L, _ m: M) -> (A, B, C, D, E, F, G, H, I, J, K, L, M) {
    (a, b, c, d, e, f, g, h, i, j, k, l, m)
}
