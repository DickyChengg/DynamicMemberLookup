//
//  Dictionary+Ext.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 13/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func toMap() -> [String: Any?] {
        return self as? [String: Any?] ?? [:]
    }
    
    func toMap() -> Map {
        let map = self as? [String: Any?] ?? [:]
        return Map(json: map)
    }
    
}
