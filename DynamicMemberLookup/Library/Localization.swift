//
//  Localization.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 13/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

@dynamicMemberLookup
final class Localization {
    private var _json: [String: String] = [:]
    private var _bundlePath: String? {
        return Bundle.main.path(
            forResource: "Localization",
            ofType: "json"
        )
    }
    
    public init(json: [String: String] = [:]) {
        if json.count == 0 {
            _loadJson()
        } else {
            _json = json
        }
    }
    
    // Note:
    /// This function are not working in this `Command Line Tools'.
    /// So, for the testing purpose, pass the json when you create
    /// the instance variable.
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
    
    /// Load from json and directly return the string.
    public subscript(dynamicMember key: String) -> String {
        let key = key.snakeCase()
        if let result: String = _json[key] {
            return result
        }
        fatalError("Key not found")
    }
    
    /// Load from json and you can do the parsing for the string.
    public subscript(dynamicMember key: String) -> LocalizeResult {
        let content: String = self[dynamicMember: key]
        return LocalizeResult(content)
    }
}

final class LocalizeResult {
    fileprivate var _localizeString: String = ""
    /// Make sure to call this variable to end the parsing.
    public var value: String {
        return _replaceAll(string: _localizeString)
    }
    
    fileprivate init(_ value: String) {
        self._localizeString = value
    }
    
    /// Replace the @{key} with value that you want to change.
    /// - Parameters:
    ///   - key: The key that are exist in the _localizeString.
    ///   - with: The value that you want to replace.
    @discardableResult
    public func set(_ key: String, with value: String) -> LocalizeResult {
        while true {
            if let range = _localizeString.range(of: "@{\(key)}") {
                _localizeString = _localizeString.replacingCharacters(in: range, with: value)
            } else {
                return self
            }
        }
    }
    
    /// Replace all @{...} in the _localizeString.
    private func _replaceAll(string: String) -> String {
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
