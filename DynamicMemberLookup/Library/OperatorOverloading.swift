//
//  OperatorOverloading.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 16/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

/// Used for convert DynamicMap to any other types.
public func <=<T>(lhs: inout T, rhs: Any?) {
    // You can not set lhs to nil,
    // because lhs is not nullable.
    let isNil: Bool = rhs is NSNull
    guard !isNil else { return }
    if let value = rhs as? T {
        lhs = value
    }
}

/// Used for convert DynamicMap to any other types.
public func <=<T>(lhs: inout T?, rhs: Any?) {
    let isNil: Bool = rhs is NSNull
    if isNil {
        lhs = nil
        return
    }
    if let value = rhs as? T {
        lhs = value
    }
}
