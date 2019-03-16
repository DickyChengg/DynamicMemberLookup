//
//  Dictionary.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 10/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

@dynamicMemberLookup
public final class DynamicMap {
    private var _data: [String: Any?] = [:]
    
    public init() { }
    
    public init(data: [String: Any]?) {
        if let data = data {
            _data = data
        }
    }
    
    public subscript <T>(dynamicMember key: String) -> T? {
        get {
            return _data[key] as? T
        } set {
            _data[key] = newValue
        }
    }
    
    public subscript <T>(dynamicMember key: String) -> [T] {
        get {
            if let value = _data[key] as? [T] {
                return value
            }
            return []
        } set {
            _data[key] = newValue
        }
    }
    
    public subscript (dynamicMember key: String) -> [Any] {
        get {
            if let value = _data[key] as? [Any] {
                return value
            }
            return []
        } set {
            _data[key] = newValue
        }
    }
    
    public subscript <T, U>(dynamicMember key: String) -> [T: U] {
        get {
            if let value = _data[key] as? [T: U] {
                return value
            }
            return [:]
        } set {
            _data[key] = newValue
        }
    }
    
    public subscript (dynamicMember key: String) -> DynamicMap {
        get {
            if let value = _data[key] as? DynamicMap {
                return value
            }
            return DynamicMap()
        } set {
            _data[key] = newValue
        }
    }
}
