//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 11/9/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation
// MARK: - LoginRequest
struct LoginRequest: Codable {
    let udacity: Udacity
}

// MARK: - Udacity
struct Udacity: Codable {
    let username, password: String
}

