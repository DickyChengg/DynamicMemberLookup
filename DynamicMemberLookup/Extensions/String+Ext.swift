//
//  String+Ext.swift
//  DynamicMemberLookup
//
//  Created by Dicky Christian on 13/03/19.
//  Copyright © 2019 Bukalapak. All rights reserved.
//

import Foundation

extension String {
    func camelCase() -> String{
        let buf:NSString = self.capitalized.replacingOccurrences(
            of: "(\\w{0,1})_",
            with: "$1",
            options: .regularExpression,
            range: nil) as NSString
        return buf.replacingCharacters(
            in: NSMakeRange(0,1),
            with: buf.substring(to: 1).lowercased()) as String
    }
    
    func snakeCase() -> String {
        let pattern = "([a-z0-9])([A-Z])"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(
            location: 0,
            length: self.count
        )
        return regex?.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1_$2").lowercased() ?? ""
    }
}
