//
//  DynamicProtocol.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 16/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

protocol ExampleDelegate {
    func doSomething()
    func dumpObject()
    func printObject()
}

protocol Mappable {
    init()
    init(map: Map)
}
