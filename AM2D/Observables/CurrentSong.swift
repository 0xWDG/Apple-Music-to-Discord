//
//  CurrentSong.swift
//  AM2D
//
//  Created by Wesley de Groot on 17/11/2024.
//

import Foundation

class CurrentSong: ObservableObject {
    @Published
    var name: String = " Music 2 Discord"
    
    @Published
    var album: String = "Waiting for  Music"

    @Published
    var artist: String = "To send song."
    
    @Published
    var image: String = ""
    
    @Published
    var state: String = ""

    @Published
    var time: Int = 0

    init() {

    }
    
    /// Set current song
    /// - Parameters:
    ///   - name: Song name
    ///   - album: Album name
    ///   - artist: Artist name
    ///   - image: Image URL
    ///   - state: Current state
    ///   - time: Time
    func set(name: String, album: String, artist: String, image: String, state: String, time: Int) {
        // swiftlint:disable:previous function_parameter_count
        self.name = name
        self.album = album
        self.artist = artist
        self.image = image
        self.state = state
        self.time = time

        objectWillChange.send()
    }
}
