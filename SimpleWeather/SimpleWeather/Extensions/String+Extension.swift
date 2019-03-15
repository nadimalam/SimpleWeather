//
//  String+Extension.swift
//  SimpleWeather
//
//  Created by Nadim Alam on 09/02/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import Foundation

extension String {
    // Removes all spaces
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    // Removes spaces before and after the string
    func removeLeadingTrailingSpaces() -> String {
        return trimmingCharacters(in: .whitespaces)
    }
}
