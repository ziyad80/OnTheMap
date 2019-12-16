//
//  RequestTokenResponse.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 11/9/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation
// MARK: - RequestTokenResponse
struct RequestTokenResponse: Codable {
    let account: Account
    let session: Session
}

// MARK: - Account
struct Account: Codable {
    let registered: Bool
    let key: String
}

// MARK: - Session
struct Session: Codable {
    let id, expiration: String
}
