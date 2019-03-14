//
//  Localization.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 13/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

@dynamicMemberLookup
class Localization {
    private var _json: [String: String] = [:]
    private var _bundlePath: String? {
        return Bundle.main.path(
            forResource: "Localization",
            ofType: "json"
        )
    }
    
    init() {
        _setJson()
//        _loadJson()
    }
    
    private func _loadJson() {
        guard let path = _bundlePath else { return }
        do {
            let data = try Data(
                contentsOf: URL(fileURLWithPath: path),
                options: []
            )
            let jsonResult = try JSONSerialization.jsonObject(
                with: data,
                options: [.mutableContainers, .allowFragments]
            )
            if let result = jsonResult as? [String: String] {
                _json = result
            }
        } catch {
            _json = [:]
        }
    }
    
    private func _setJson() {
        _json = [
            "first": "satu",
            "second": "dua",
            "title": "Judul",
            "macbook_pro": "Macbook Pro",
            "test_parse": "test @{key1} @{key2} @{key3} @{key4}"
        ]
    }
    
    enum Key: String {
        case first
        case second
        case title
    }
    
    func get(key: Key) -> String {
        let key = key.rawValue.snakeCase()
        return _json[key] ?? ""
    }
    
    subscript(dynamicMember key: String) -> String {
        let key = key.snakeCase()
        if let result: String = _json[key] {
            return result
        }
        fatalError("Key tidak ditemukan")
    }
    
    subscript(dynamicMember key: String) -> LocalizeResult {
        let content: String = self[dynamicMember: key]
        return LocalizeResult(content)
    }
}

class LocalizeResult {
    fileprivate var localizeString: String = ""
    var value: String {
        return replaceAll(string: localizeString)
    }
    
    fileprivate init(_ value: String) {
        self.localizeString = value
    }
    
    @discardableResult
    func set(_ key: String, with value: String) -> LocalizeResult {
        while true {
            if let range = localizeString.range(of: "@{\(key)}") {
                localizeString = localizeString.replacingCharacters(in: range, with: value)
            } else {
                return self
            }
        }
    }
    
    func replaceAll(string: String) -> String {
        var str: String = string
        let regex = try? NSRegularExpression(pattern: "\\@\\{[a-z0-9]+\\}")
        let foundTags = regex?.matches(
            in: string,
            range: NSRange(location: 0, length: string.count)
        )
        if let tags = foundTags {
            let result: NSString = string as NSString
            tags.map { result.substring(with: $0.range) }.forEach {
                str = str.replacingOccurrences(of: $0, with: "")
            }
        }
        return str
    }
}
