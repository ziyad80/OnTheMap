//
//  OnTheMapRespons.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 11/9/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation
struct OnTheMapRespons: Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}

extension OnTheMapRespons: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}
