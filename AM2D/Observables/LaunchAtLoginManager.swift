//
//  LaunchAtLoginManager.swift
//  AM2D
//
//  Created by Wesley de Groot on 20/08/2026.
//

import ServiceManagement

@MainActor
final class LaunchAtLoginManager: ObservableObject {
    @Published private(set) var isEnabled = false
    @Published private(set) var statusMessage: String?

    init() {
        refresh()
    }

    func setEnabled(_ enabled: Bool) {
        do {
            if enabled {
                try SMAppService.mainApp.register()
            } else {
                try SMAppService.mainApp.unregister()
            }
            refresh()
        } catch {
            refresh()
            statusMessage = error.localizedDescription
        }
    }

    private func refresh() {
        switch SMAppService.mainApp.status {
        case .enabled:
            isEnabled = true
            statusMessage = nil
        case .requiresApproval:
            isEnabled = true
            statusMessage = "Approval is required in System Settings."
        case .notRegistered:
            isEnabled = false
            statusMessage = nil
        case .notFound:
            isEnabled = false
            statusMessage = "Launch at login is unavailable for this app."
        @unknown default:
            isEnabled = false
            statusMessage = "Launch at login status is unavailable."
        }
    }
}
