//
//  Double+Extension.swift
//  SimpleWeather
//
//  Created by Nadim Alam on 09/02/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import Foundation

extension Double {
    var formatAsDegree: String {
        return String(format: "%.0f°", self)
    }
}
