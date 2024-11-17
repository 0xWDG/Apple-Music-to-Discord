//
//  MusicBridge.swift
//  AM2D
//
//  Created by Wesley de Groot on 04/12/2023.
//

import Foundation
import ScriptingBridge

@objc public protocol SBObjectProtocol: NSObjectProtocol {
    func get() -> Any!
}

@objc public protocol SBApplicationProtocol: SBObjectProtocol {
    func activate()
    var delegate: SBApplicationDelegate! { get set }
    var isRunning: Bool { get }
}

// MARK: MusicEPlS
@objc public enum MusicEPlS: AEKeyword {
    case stopped = 0x6b505353 /* 'kPSS' */
    case playing = 0x6b505350 /* 'kPSP' */
    case paused = 0x6b505370 /* 'kPSp' */
    case fastForwarding = 0x6b505346 /* 'kPSF' */
    case rewinding = 0x6b505352 /* 'kPSR' */
}

// MARK: MusicItem
@objc public protocol MusicItem: SBObjectProtocol {
    /// the name of the item
    @objc optional var name: String { get }
}
extension SBObject: MusicItem {}

// MARK: MusicTrack
@objc public protocol MusicTrack: MusicItem {
    /// the album name of the track
    @objc optional var album: String { get }
    /// the artist/source of the track
    @objc optional var artist: String { get }
    /// the stop time of the track in seconds
    @objc optional var finish: Double { get }
}

extension SBObject: MusicTrack {}

// MARK: MusicApplication
@objc public protocol MusicApplication: SBApplicationProtocol {
    /// the current targeted track
    @objc optional var currentTrack: MusicTrack { get }
    /// is the player stopped, paused, or playing?
    @objc optional var playerState: MusicEPlS { get }
    /// the player’s position within the currently playing track in seconds.
    @objc optional var playerPosition: Double { get }
}
extension SBApplication: MusicApplication {}
