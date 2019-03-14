//
//  Dictionary.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 10/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

@dynamicMemberLookup
final class DynamicMap {
    private var _data: [String: Any] = [:]
    var test: String = "ini static test"
    
    init() { }
    
    init(data: [String: Any]?) {
        if let data = data {
            _data = data
        }
    }
    
    subscript (dynamicMember key: String, key2: String) -> String {
        get {
            if let str = _data[key] as? String {
                return "\(str)"
            }
            return ""
        } set {
            _data[key] = "\(newValue)-\(key2)"
        }
    }
    
    subscript (dynamicMember key: String) -> String {
        get {
            if let str = _data[key] as? String {
                return str
            }
            return ""
        } set {
            _data[key] = newValue
        }
    }
    
    subscript (dynamicMember key: String) -> Int64 {
        get {
            if let str = _data[key] as? String, let int = Int64(str) {
                return int
            }
            if let int = _data[key] as? Int64 {
                return int
            }
            return 0
        } set {
            _data[key] = newValue
        }
    }
    
    subscript <T>(dynamicMember key: String) -> T? {
        get {
            return _data[key] as? T
        } set {
            _data[key] = newValue
        }
    }
    
    subscript <T>(dynamicMember key: String) -> [T] {
        get {
            return _data[key] as? [T] ?? []
        } set {
            _data[key] = newValue
        }
    }
    
    subscript (dynamicMember key: String) -> [Any] {
        get {
            return _data[key] as? [Any] ?? []
        } set {
            _data[key] = newValue
        }
    }
    
    subscript <T, U>(dynamicMember key: String) -> [T: U] {
        get {
            return _data[key] as? [T: U] ?? [:]
        } set {
            _data[key] = newValue
        }
    }
    
//    subscript <T: RawRepresentable>(dynamicMember key: String) -> T? {
//        get {
//            if let value = _data[key] as? T.RawValue {
//                return T(rawValue: value)
//            }
//            return nil
//        } set {
//            _data[key] = newValue
//        }
//    }
//
//    subscript <T: RawRepresentable>(dynamicMember key: String) -> [T?] {
//        get {
//            if let values = _data[key] as? [T.RawValue] {
//                let result: [T?] = values.map { T(rawValue: $0) }
//                return result
//            }
//            return []
//        } set {
//            _data[key] = newValue
//        }
//    }
    
    subscript (dynamicMember key: String) -> DynamicMap {
        get {
            return _data[key] as? DynamicMap ?? DynamicMap()
        } set {
            _data[key] = newValue
        }
    }
}
