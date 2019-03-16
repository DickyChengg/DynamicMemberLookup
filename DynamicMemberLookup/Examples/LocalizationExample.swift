//
//  LocalizationExample.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 16/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

final class LocalizationExample {
    private lazy var _json: [String: String] = _createJson()
    lazy var R: Localization = Localization(json: _json)
    
    private func _createJson() -> [String: String] {
        var json: [String: String] = [:]
        json["first"] = "one"
        json["second"] = "two"
        json["third"] = "three"
        json["fourth"] = "four"
        json["greeting"] = "@{greet} Morning, @{greet} Afternoon, @{greet} Evening, @{greet} Night."
        json["try_parsing"] = "try parsing 4 keys to @{key1} @{key2} @{key3} @{key4}"
        return json
    }
}

extension LocalizationExample: ExampleDelegate {
    func doSomething() {
        // Do your experiment here.
    }
    
    func dumpObject() {
        print("Dump Json:")
        dump(_json)
    }
    
    func printObject() {
        let one: String = R.first
        let two: String = R.second
        let three: String = R.third
        let four: String = R.fourth
        let greeting: String = R.greeting.set("greet", with: "Good").value
        let tryParsing1: String = R.tryParsing
            .set("key1", with: "k-1")
            .set("key2", with: "k-2")
            .set("key3", with: "k-3")
            .set("key4", with: "k-4")
            .value
        let tryParsing2: String = R.tryParsing
            .set("key3", with: "k-3")
            .set("key1", with: "k-1")
            .set("key4", with: "k-4")
            .set("key2", with: "k-2")
            .value
        
        print()
        print("Print Json:")
        print()
        print("first:", one)
        print("second:", two)
        print("third:", three)
        print("fourth:", four)
        print("greeting:", greeting)
        print("try_parsing:", tryParsing1)
        print("try_parsing:", tryParsing2)
    }
}
