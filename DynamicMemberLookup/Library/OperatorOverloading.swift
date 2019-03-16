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
    if let value = rhs as? T {
        lhs = value
    }
}

/// Used for convert DynamicMap to any other types.
public func <=<T>(lhs: inout T?, rhs: Any?) {
    if rhs is NSNull {
        lhs = nil
        return
    }
    if let value = rhs as? T {
        lhs = value
    }
}
