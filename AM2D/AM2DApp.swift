//
//  File.swift
//  AM2D
//
//  Created by Wesley de Groot on 01/12/2023.
//

import SwiftUI
import SwordRPC
import ScriptingBridge
import OSLog

class AppDelegate: NSObject, NSApplicationDelegate {
    /// Sword RPC
    private var rpc = SwordRPC(appId: DISCORD_API_KEY)

    /// Popover (for statusbar item)
    private var popover = NSPopover.init()

    /// Status bar item
    private var statusBarItem: NSStatusItem?

    /// Auto start Apple Music
    private var autoStartAM = false

    /// Is IPC/RPC Connected
    private var RPCConnected = false

    /// Logger
    private let log = Logger(
        subsystem: "nl.wesleydegroot.am2d",
        category: "AppDelegate"
    )

    private let AMApp: MusicApplication? = SBApplication(
        bundleIdentifier: "com.apple.Music"
    )

    private let AMAppSB: SBApplicationProtocol? = SBApplication(
        bundleIdentifier: "com.apple.Music"
    )

    @ObservedObject
    var currentSong: CurrentSong = .init()

    @ObservedObject
    var sharedData: SharedData = .init()

    @objc
    func updateTrack (notification: NSNotification) {
        DispatchQueue.global(qos: .background).async {
            if let info = notification.userInfo {
                var presence = RichPresence()
                presence.type = .LISTENING

                let name = info["Name"] as? String ?? "Unknown"
                let artist = info["Artist"] as? String ?? "Unknown"
                let album = info["Album"] as? String ?? "Unknown"
                let playerState = info["Player State"] as? String ?? "Unknown"
                let totalTime = info["Total Time"] as? Int ?? 0

                if playerState == "Playing" {
                    DispatchQueue.main.async {
                        self.sharedData.isPlaying = true
                    }
                    presence.details = name
                    let endsAt = Double(totalTime) / 1000
                    presence.timestamps.start = Int(Date().timeIntervalSince1970)
                    presence.timestamps.end = Int((Date() + endsAt).timeIntervalSince1970)
                } else {
                    DispatchQueue.main.async {
                        self.sharedData.isPlaying = false
                    }
                    presence.details = "⏸︎ \(name)"
                    presence.assets.smallImage = "pause"
                    presence.assets.smallText = "Paused"
                }
                presence.state = artist

                if let image = self.getImage(forAlbum: album, fromArtist: artist) {
                    presence.assets.largeImage = image
                    presence.assets.smallImage = "am"
                } else {
                    presence.assets.largeImage = "am"
                    presence.assets.smallImage = nil
                }

                presence.assets.largeText = (artist + " - " + album)

                DispatchQueue.main.async {
                    self.currentSong.set(
                        name: name,
                        album: album,
                        artist: artist,
                        image: presence.assets.largeImage!,
                        state: playerState,
                        time: totalTime
                    )
                }

                self.rpc.setPresence(presence)
            }
        }
    }

    func getImage(forAlbum: String, fromArtist: String) -> String? {
        let encodedTerm: String = "\(forAlbum) \(fromArtist)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        if let country: String = Locale.current.language.region?.identifier,
           let url: URL = URL(
            string: "https://itunes.apple.com/search?term=\(encodedTerm)" +
                    "&media=music&entity=album&country=\(country)&limit=1"
            ),
           let data = try? Data(contentsOf: url),
           let json = try? JSONDecoder().decode(itunesSearch.self, from: data) {
            return json.results.first?.artworkUrl100
        }

        return nil
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        let contentView = ContentView()
            .environmentObject(currentSong)
            .environmentObject(sharedData)

        popover.behavior = .transient
        popover.animates = false
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.button?.title = "M2D"
        statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))

        let notificationCenter = DistributedNotificationCenter.default()
        rpc.onConnect { _ in
            self.RPCConnected = true
            self.getCurrentTrack()

            notificationCenter.addObserver(
                self,
                selector: #selector(self.updateTrack),
                name: NSNotification.Name(rawValue: "com.apple.Music.playerInfo"),
                object: nil
            )
        }
        rpc.onDisconnect { _, code, message in
            self.RPCConnected = false

            notificationCenter.removeObserver(
                self,
                name: NSNotification.Name(rawValue: "com.apple.Music.playerInfo"),
                object: nil
            )
        }

        loop()
    }

    func loop() {
        if !RPCConnected {
            rpc.connect()
        }

        if currentSong.name == " Music 2 Discord" {
            self.getCurrentTrack()
        }

        self.sharedData.appleMusicRunning = AMAppSB?.isRunning ?? false
        self.sharedData.discordRunning = RPCConnected

        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: loop)
    }

    func getCurrentTrack() {
        guard let app = AMAppSB,
            app.isRunning else {
                log.debug("Apple Music is not running!")
                if autoStartAM {
                    AMAppSB?.activate()
                }
            return
        }

        if let currentAMTrack = self.AMApp?.currentTrack as? MusicTrack {
            self.updateTrack(
                notification: .init(
                    name: NSNotification.Name(rawValue: "com.apple.Music.playerInfo"),
                    object: nil, userInfo: [
                        "Name": currentAMTrack.name as Any,
                        "Album": currentAMTrack.album as Any,
                        "Artist": currentAMTrack.artist as Any,
                        "Total Time": Int((currentAMTrack.finish ?? 0) * 1000) as Any,
                        "Player State": self.AMApp?.playerState == .playing ? "Playing" : "Paused"
                    ]
                )
            )
        }
    }

    @objc func showPopover(_ sender: AnyObject?) {
        if let button = statusBarItem?.button {
            popover.show(
                relativeTo: button.bounds,
                of: button,
                preferredEdge: NSRectEdge.minY
            )
        }
    }

    @objc func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        sharedData.debug = NSEvent.modifierFlags.contains(.option)

        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
}

@main
struct AM2DApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDegelate
    var body: some Scene {
        Settings {
            Text("This will never been shown.")
        }
    }
}
