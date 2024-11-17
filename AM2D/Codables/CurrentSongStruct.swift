//
//  CurrentSongStruct.swift
//  AM2D
//
//  Created by Wesley de Groot on 17/11/2024.
//

import Foundation

struct CurrentSongStruct: Codable {
    var name: String
    var album: String
    var artist: String
    var image: String
    var state: String
    var time: Int
}
