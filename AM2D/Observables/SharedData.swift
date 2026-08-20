//
//  SharedData.swift
//  AM2D
//
//  Created by Wesley de Groot on 17/11/2024.
//

import Foundation

enum PlaybackState: String {
    case stopped = "Stopped"
    case playing = "Playing"
    case paused = "Paused"

    init(notificationValue: String) {
        switch notificationValue.lowercased() {
        case "playing": self = .playing
        case "paused": self = .paused
        default: self = .stopped
        }
    }

    var systemImage: String {
        switch self {
        case .stopped: return "stop.fill"
        case .playing: return "play.fill"
        case .paused: return "pause.fill"
        }
    }

    var indicator: String {
        switch self {
        case .stopped: return "■"
        case .playing: return "▶"
        case .paused: return "Ⅱ"
        }
    }

    var discordAssetName: String {
        switch self {
        case .stopped: return "stop"
        case .playing: return "play"
        case .paused: return "pause"
        }
    }
}

class SharedData: ObservableObject {
    @Published
    var discordRunning: Bool = false

    @Published
    var appleMusicRunning: Bool = false

    @Published
    var playbackState: PlaybackState = .stopped

    @Published
    var debug: Bool = false
}
