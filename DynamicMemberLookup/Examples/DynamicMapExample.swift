//
//  DynamicMapExample.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 16/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

final class DynamicMapExample {
    let secondVC: UserData = UserData()
    
    private func _passAllData() {
        let data = DynamicMap()
        data.name = "John"
        data.age = 40
        data.gender = Gender.male
        data.phoneNumber = "+12 3456 7890 10 29"
        data.hasMarried = true
        data.childrenName = ["Alice", "Bob"]
        secondVC.set(data: data)
    }
    
    private func _passHalfData() {
        let data = DynamicMap()
        data.name = "John Doe"
        data.hasMarried = false
        data.childrenName = ["Alice", "Bob", "Carl"]
        secondVC.set(data: data)
    }
    
    private func _passAllNilData() {
        let data = DynamicMap()
        data.name = NSNull()
        data.age = NSNull()
        data.gender = NSNull()
        data.phoneNumber = NSNull()
        data.hasMarried = NSNull()
        data.childrenName = NSNull()
        secondVC.set(data: data)
    }
}

extension DynamicMapExample: ExampleDelegate {
    func doSomething() {
        print("Pass Half Data")
        _passHalfData()
        dumpObject()
        print("Pass All Data")
        _passAllData()
        dumpObject()
        print("Pass All Nil")
        _passAllNilData()
        dumpObject()
        print("Pass All Data")
        _passAllData()
    }
    
    func dumpObject() {
        print("Dump Data:")
        dump(secondVC)
        print()
    }
    
    func printObject() {
        print()
        print("Print Data:")
        print()
        print("Name:", secondVC.name)
        print("Age:", secondVC.age)
        print("Gender:", secondVC.gender)
        print("Phone Number:", secondVC.phoneNumber)
        print("Has Married:", secondVC.hasMarried)
        print("Children Name:", secondVC.childrenName)
    }
}

final class UserData {
    var name: String = ""
    var age: Int = 0
    var gender: Gender?
    var phoneNumber: String?
    var hasMarried: Bool = false
    var childrenName: [String] = []
    
    func set(data: DynamicMap) {
        name <= data.name
        age <= data.age
        gender <= data.gender
        phoneNumber <= data.phoneNumber
        hasMarried <= data.hasMarried
        childrenName <= data.childrenName
    }
}
