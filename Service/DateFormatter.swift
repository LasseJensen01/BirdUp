//
//  DateFormatter.swift
//  BirdUp
//
//  Created by dmu mac 26 on 10/12/2024.
//

import Foundation

extension Date {
    var formattedDescription: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
