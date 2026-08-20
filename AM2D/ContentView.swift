//
//  ContentView.swift
//  AM2D
//
//  Created by Wesley de Groot on 01/12/2023.
//

import SwiftUI
import ScriptingBridge
import MusicKit
import OSLog

struct ContentView: View {
    private let AMApp: SBApplicationProtocol = SBApplication(
        bundleIdentifier: "com.apple.Music"
    )!

    private let log = Logger(
        subsystem: "nl.wesleydegroot.am2d",
        category: "ContentView"
    )

    @EnvironmentObject
    var currentSong: CurrentSong

    @EnvironmentObject
    var sharedData: SharedData

    @StateObject
    private var launchAtLogin = LaunchAtLoginManager()

    @State
    var fancyBG: Bool = false

    var body: some View {
        ScrollView {
            Text(" ")
                .font(.title)
                .fontWeight(.heavy)

            Text(" Music 2 Discord")
                .font(.title)
                .fontWeight(.heavy)

            Text("Version 1.0.0 (beta)")
                .font(.subheadline)
                .fontWeight(.light)

            VStack {
                if currentSong.image.hasPrefix("http") {
                    AsyncImage(url: URL(string: currentSong.image))
                        .accessibilityLabel("Album artwork for \(currentSong.name)")
                }
            }
            .frame(width: 100, height: 100)

            Form {
                LabeledContent("Status") {
                    Label(
                        sharedData.playbackState.rawValue,
                        systemImage: sharedData.playbackState.systemImage
                    )
                    .accessibilityLabel(
                        "Playback status: \(sharedData.playbackState.rawValue)"
                    )
                }
                LabeledContent(
                    "Song",
                    value: currentSong.name
                )
                LabeledContent(
                    "Artist",
                    value: currentSong.artist
                )
                LabeledContent(
                    "Album",
                    value: currentSong.album
                )

                Toggle(
                    "Launch at Login",
                    isOn: Binding(
                        get: { launchAtLogin.isEnabled },
                        set: { launchAtLogin.setEnabled($0) }
                    )
                )
                .accessibilityHint("Starts Apple Music to Discord when you log in")

                if let statusMessage = launchAtLogin.statusMessage {
                    Text(statusMessage)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .accessibilityLabel("Launch at login: \(statusMessage)")
                }
            }

            HStack {
                Button("⏪︎", action: {
                    AM(action: "play previous track")
                })
                .focusable(false)
                .accessibilityLabel("Previous track")
                .accessibilityHint("Plays the previous track in Apple Music")

                Button("⏯︎", action: {
                    AM(action: "playpause")
                })
                .focusable(false)
                .accessibilityLabel("Play or pause")
                .accessibilityHint("Toggles playback in Apple Music")

                Button("⏩︎", action: {
                    AM(action: "next track")
                })
                .focusable(false)
                .accessibilityLabel("Next track")
                .accessibilityHint("Plays the next track in Apple Music")
            }

            if sharedData.debug {
                HStack {
                    Text("Debug: ")
                    Text("Discord ")
                        .foregroundColor(
                            sharedData.discordRunning
                            ? .green
                            : .red
                        )

                    Text(sharedData.playbackState.indicator)
                        .accessibilityLabel(sharedData.playbackState.rawValue)

                    Text("Apple Music ")
                        .foregroundColor(
                            sharedData.appleMusicRunning
                            ? .green
                            : .red
                        )
                }
            }

            Button("Quit", action: {
                NSApplication.shared.terminate(.none)
            })
            .accessibilityLabel("Quit Apple Music to Discord")
        }
        .background {
            if fancyBG {
                AsyncImage(
                    url: URL(string: currentSong.image),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity
                            )
                            .blur(radius: 20)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }

    func AM(action: String) {
        if !AMApp.isRunning {
            log.error("Apple Music is not running?")
            return
        }

        DispatchQueue.global().async {
            let scpt = "tell application \"Music\" to \(action)"
            if let script = NSAppleScript(source: scpt) {
                var errorInfo: NSDictionary?
                script.executeAndReturnError(&errorInfo)
                log.debug("\(scpt)")
                if let errorInfo {
                    log.error("Apple Music command failed: \(errorInfo)")
                }
                log.debug("\(String(describing: script))")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CurrentSong())
            .environmentObject(SharedData())
    }
}
