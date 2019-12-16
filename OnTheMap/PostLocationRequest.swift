//
//  PostLocationRequest.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 12/5/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation
struct PostLocationRequest: Codable {
    let firstName, lastName: String
    let longitude, latitude: Double
    let mapString, mediaURL, uniqueKey: String
}
