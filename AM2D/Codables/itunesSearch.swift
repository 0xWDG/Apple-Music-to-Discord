//
//  itunesSearch.swift
//  AM2D
//
//  Created by Wesley de Groot on 17/11/2024.
//

import Foundation

struct itunesSearch: Codable { // swiftlint:disable:this type_name
    let resultCount: Int
    let results: [results]

    struct results: Codable { // swiftlint:disable:this type_name
        let artworkUrl100: String
    }
}
