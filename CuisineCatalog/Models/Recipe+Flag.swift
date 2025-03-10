//
//  Recipe+Flag.swift
//  CuisineCatalog
//
//  Created by Andrew Fannin on 3/7/25.
//

import Foundation

// Note: Ideally, our API would provide country codes so we could set the flags based on that. I thought having the flags in the List items would look nice, so manually adding country codes based on the cuisine type.
extension Recipe {
    static private let countryCodes: [String: String] = [
        "american": "US",
        "british": "GB",
        "canadian": "CA",
        "croatian": "HR",
        "french": "FR",
        "greek": "GR",
        "italian": "IT",
        "japanese": "JP",
        "malaysian": "MY",
        "polish": "PL",
        "portuguese": "PT",
        "russian": "RU",
        "tunisian": "TN"
    ]
    
    /// Credit to this SO post for generating unicode to get flag emoji from country code:
    /// https://stackoverflow.com/a/30403199
    static func getFlagEmoji(for cuisine: String) -> String {
        guard let code = Self.countryCodes[cuisine.lowercased()] else {
            return "🏳️"
        }
        
        let base : UInt32 = 127397
        var s = ""
        for v in code.unicodeScalars {
            guard let unicode = UnicodeScalar(base + v.value) else {
                continue
            }
             s.unicodeScalars.append(unicode)
         }
         return String(s)
    }
}
