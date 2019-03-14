//
//  main.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 10/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

enum Gender: String {
    case male
    case female
}

class User: Mappable {
    var name: String = ""
    var age: Int64 = 0
    var height: Float = 0
    var gender: Gender?
    var childGender: [Gender?] = []
    var favoriteColors: [String] = []
    var house: House?
    var test: [House] = []
    
    required init() {
        
    }
    
    required init(map: Map) {
        name = map.name
        age = map.age
        height = map.height
        gender = map.gender
        childGender = map.childGender
        favoriteColors = map.favoriteColors
        house = map.house
        test = map.test
    }
}

class House: Mappable {
    var address: String = ""
    var number: Int = 0
    
    required init() {
        
    }
    
    required init(map: Map) {
        address = map.address
        number = map.number
    }
}

let houseDict: [String: Any?] = [
    "address": "Jl. Palang Merah",
    "number": 12
]

let response: Map = [
    "name": "Reino",
    "age": 12,
    "height": Float(170.2),
    "gender": "male",
    "child_gender": [
        "male",
        "male",
        "female",
        "female"
    ],
    "favorite_colors": ["red", "green"],
    "house": houseDict,
    "test": [
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

let user = User(map: response)
dump(user)
