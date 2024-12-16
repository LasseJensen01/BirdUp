//
//  Quote.swift
//  BirdUp
//
//  Created by dmu mac 26 on 12/12/2024.
//
import Foundation

struct Quote: Decodable {
    let id: Int
    let author: String
    let quote: String
}
