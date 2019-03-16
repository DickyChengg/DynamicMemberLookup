//
//  ObjectMapper.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 16/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

// ------------------ Mark: Models ------------------
// Note:
// For ObjectMapper we use 'Map' class.

enum Gender: String {
    case male
    case female
}

final class User: Mappable {
    var name: String = ""
    var age: Int64 = 0
    var height: Float = 0
    var gender: Gender?
    var childrenGender: [Gender?] = []
    var favoriteColors: [String] = []
    var house: House?
    var childrenHouses: [House] = []
    
    required init() { }
    
    required init(map: Map) {
        name = map.name
        age = map.age
        height = map.height
        gender = map.gender
        childrenGender = map.childrenGender
        favoriteColors = map.favoriteColors
        house = map.house
        childrenHouses = map.childrenHouses
    }
}

final class House: Mappable {
    var address: String = ""
    var number: Int = 0
    
    required init() { }
    
    required init(map: Map) {
        address = map.address
        number = map.number
    }
}

// ------------------ Mark: Example ------------------
final class ObjectMapperExample {
    var model: User
    private let response: Map = [
        "name": "Reino",
        "age": Int64(1200),
        "height": Float(170.2),
        "gender": "male",
        "children_gender": [
            "male",
            "male",
            "female",
            "female"
        ],
        "favorite_colors": ["red", "green"],
        "house": [
            "address": "Jl. Palang Merah",
            "number": 12
        ],
        "children_houses": [
            [
                "address": "Jl. Palang Kuning",
                "number": 13
            ],
            [
                "address": "Jl. Palang Hijau",
                "number": 14
            ]
        ]
    ].toMap()
    
    init() {
        model = User(map: response)
    }
}

extension ObjectMapperExample: ExampleDelegate {
    func doSomething() {
        // Do your experiment here.
    }
    
    func dumpObject() {
        print("Dump Model:")
        dump(model)
    }
    
    func printObject() {
        print()
        print("Print Model:")
        print()
        print("Name:", model.name)
        print("Age:", model.age)
        print("Height:", model.height)
        if let gender = model.gender {
            print("Gender:", gender)
        } else {
            print("Gender: nil")
        }
        print("Child Gender:", model.childrenGender)
        print("Favorite Colors:", model.favoriteColors)
        if let house = model.house {
            print("House Address:", house.address)
            print("House Number:", house.number)
        } else {
            print("House: nil")
        }
        print("Children House:")
        for (index, house) in model.childrenHouses.enumerated() {
            print("Child[\(index)] Address:", house.address)
            print("Child[\(index)] Number:", house.number)
        }
    }
}
