//
//  main.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 10/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

// Note:
// If you want to try something new by changing the code,
// Go directly to the Example class. (in doSomething function).

enum Example {
    case localization
    case objectMapper
    case dynamicMap
}

func showExample(of menu: Example) {
    let example: ExampleDelegate = ObjectMapperExample()
    example.doSomething()
    example.dumpObject()
    example.printObject()
}

// Change this one to see the example.
showExample(of: .objectMapper)
