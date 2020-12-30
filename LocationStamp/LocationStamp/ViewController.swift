//
//  ViewController.swift
//  LocationStamp
//
//  Created by 김종권 on 2020/12/29.
//

import UIKit

enum Person {
    case name(String)
    case age(Int)
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let person: Person = .name("이름")

        //
switch person {
case .name(let nameValue):
    print(nameValue)
case .age(let ageValue):
    print(ageValue)
}

        //
if case let Person.name(nameValue) = person {
    print(nameValue)
}

guard case let Person.name(nameValue) = person else {
    print("not exist")
    return
}
print(nameValue)
    }


}

