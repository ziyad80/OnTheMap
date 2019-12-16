//
//  StudenLocationsRequest.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 11/12/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation
struct StudenLocationsRequest: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable, Equatable {
    let firstName, lastName: String
    let longitude, latitude: Double
    let mapString, mediaURL, uniqueKey, objectID: String
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case firstName, lastName, longitude, latitude, mapString, mediaURL, uniqueKey
        case objectID = "objectId"
        case createdAt, updatedAt
    }
}
