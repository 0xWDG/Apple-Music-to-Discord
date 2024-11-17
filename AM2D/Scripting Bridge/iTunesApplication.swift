//
//  iTunesApplication.swift
//  AM2D
//
//  Created by Wesley de Groot on 17/11/2024.
//

import Foundation

@objc protocol iTunesApplication { // swiftlint:disable:this type_name
    @objc optional func currentTrack() -> AnyObject
    @objc optional var properties: NSDictionary { get }
}
