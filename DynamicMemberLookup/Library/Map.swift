//
//  Map.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 12/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

@dynamicMemberLookup
final class Map {
    private var json: [String: Any?] = [:]
    
    init() { }
    
    init(json: [String: Any?]) {
        self.json = json
    }
    
    private func _get(_ key: String) -> Any? {
        let camelCase = key.snakeCase()
        return json[camelCase] ?? nil
    }
    
    // to SwiftType
    subscript <T>(dynamicMember key: String) -> T {
        return _get(key) as! T
    }
    
    subscript (dynamicMember key: String) -> String {
        if let str = _get(key) as? String {
            return str
        }
        if let int = _get(key) as? Int64 {
            return "\(int)"
        }
        return ""
    }
    
    subscript (dynamicMember key: String) -> Int64 {
        if let str = _get(key) as? String, let int = Int64(str) {
            return int
        }
        if let int = _get(key) as? Int64 {
            return int
        }
        return 0
    }
    
    subscript (dynamicMember key: String) -> Float {
        if let str = _get(key) as? String, let flt = Float(str) {
            return flt
        }
        if let flt = _get(key) as? Float {
            return flt
        }
        return 0
    }
    
    // to optional<SwiftType>
    subscript <T>(dynamicMember key: String) -> T? {
        return _get(key) as? T
    }
    
    subscript (dynamicMember key: String) -> String? {
        if let str = _get(key) as? String {
            return str
        }
        if let int = _get(key) as? Int64 {
            return "\(int)"
        }
        return nil
    }
    
    subscript (dynamicMember key: String) -> Int64? {
        if let str = _get(key) as? String {
            return Int64(str)
        }
        if let int = _get(key) as? Int64 {
            return int
        }
        return nil
    }
    
    subscript (dynamicMember key: String) -> Float? {
        if let str = _get(key) as? String {
            return Float(str)
        }
        if let flt = _get(key) as? Float {
            return flt
        }
        return nil
    }
    
    // to optional<RawRepresentable>
    subscript <T: RawRepresentable>(dynamicMember key: String) -> T? {
        if let value = _get(key) as? T.RawValue {
            return T(rawValue: value)
        }
        return nil
    }
    
    
    // to object
    subscript <T: Mappable>(dynamicMember key: String) -> T {
        let map: Map
        if let values = _get(key) as? [String: Any?] {
            map = Map(json: values)
        } else {
            map = Map()
        }
        return T(map: map)
    }
    
    // to optional<object>
    subscript <T: Mappable>(dynamicMember key: String) -> T? {
        if let values = _get(key) as? [String: Any?] {
            let map = Map(json: values)
            return T(map: map)
        }
        return nil
    }
    
    // Mark: Array
    // ------------------------
    
    // to array<optional<RawRepresentable>>
    subscript <T: RawRepresentable>(dynamicMember key: String) -> [T?] {
        if let values = _get(key) as? [T.RawValue] {
            let result: [T?] = values.map { T(rawValue: $0) }
            return result
        }
        return []
    }
    
    // to array<object>
    subscript <T: Mappable>(dynamicMember key: String) -> [T] {
        if let values = _get(key) as? [[String: Any?]] {
            let result: [T] = values.map {
                let map = Map(json: $0)
                return T(map: map)
            }
            return result
        }
        return []
    }
    
    // to array<optional<object>>
    subscript <T: Mappable>(dynamicMember key: String) -> [T?] {
        if let values = _get(key) as? [[String: Any?]] {
            let result: [T?] = values.map {
                let map = Map(json: $0)
                return T(map: map)
            }
            return result
        }
        return []
    }
    
    // to optional<array<object>>
    subscript <T: Mappable>(dynamicMember key: String) -> [T]? {
        if let values = json[key] as? [[String: Any?]] {
            let result: [T] = values.map {
                let map = Map(json: $0)
                return T(map: map)
            }
            return result
        }
        return nil
    }
    
    // to ShortDate ?
    // to LongDate ?
}
