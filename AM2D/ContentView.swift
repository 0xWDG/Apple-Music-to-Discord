//
//  File.swift
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
                }
            }
            .frame(width: 100, height: 100)

            Form {
                LabeledContent(
                    "Status",
                    value: sharedData.isPlaying
                    ? "► (Playing)"
                    : "⏸︎ (Paused)"
                )
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
            }

            HStack {
                Button("⏪︎", action: {
                    AM(action: "play previous track")
                })
                .focusable(false)

                Button("⏯︎", action: {
                    AM(action: "playpause")
                })
                .focusable(false)

                Button("⏩︎", action: {
                    AM(action: "next track")
                })
                .focusable(false)
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

                    Text(
                        sharedData.isPlaying
                        ? "►"
                        : "⏸︎"
                    )

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
                var errDict: AutoreleasingUnsafeMutablePointer<NSDictionary?>?
                script.executeAndReturnError(errDict)
                log.debug("\(scpt)")
                log.error("\(String(describing: errDict))")
                log.debug("\(String(describing: script))")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CurrentSong())
    }
}
