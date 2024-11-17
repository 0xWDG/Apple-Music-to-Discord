//
//  SharedData.swift
//  AM2D
//
//  Created by Wesley de Groot on 17/11/2024.
//

import Foundation

class SharedData: ObservableObject {
    @Published
    var discordRunning: Bool = false

    @Published
    var appleMusicRunning: Bool = false

    @Published
    var isPlaying: Bool = false

    @Published
    var debug: Bool = false
}
