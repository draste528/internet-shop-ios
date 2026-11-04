//
//  URL+Validation.swift
//  InternetShop
//
//  Created by kair on 03.11.26.
//

import Foundation

extension URL {
    /// Schemes accepted by default: web resources and files on the device.
    nonisolated static let defaultAllowedSchemes: Set<String> = ["http", "https", "file"]

    /// Builds a URL from a raw string that points either to a web resource or to a local file.
    /// Accepts:
    /// - `http(s)://host/...` — must contain a host;
    /// - `file:///path/...` — must contain a path;
    /// - absolute file system paths (`/var/mobile/...`) — converted to a file URL;
    /// - any other scheme listed in `allowedSchemes`.
    /// Returns nil for empty strings, relative paths and schemes that are not allowed.
    /// - Parameter allowedSchemes: lowercase scheme names; pass a custom set to narrow or extend the defaults.
    nonisolated init?(validatedString rawValue: String, allowedSchemes: Set<String> = URL.defaultAllowedSchemes) {
        let string = rawValue.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !string.isEmpty else { return nil }

        // Absolute local path without a scheme, e.g. a file in the app sandbox.
        if string.hasPrefix("/") {
            guard allowedSchemes.contains("file") else { return nil }
            self = URL(filePath: string)
            return
        }

        guard let url = URL(string: string),
              let scheme = url.scheme?.lowercased(),
              allowedSchemes.contains(scheme) else {
            return nil
        }

        switch scheme {
        case "http", "https":
            guard url.host()?.isEmpty == false else { return nil }
        case "file":
            guard !url.path().isEmpty else { return nil }
        default:
            break
        }
        self = url
    }
}
