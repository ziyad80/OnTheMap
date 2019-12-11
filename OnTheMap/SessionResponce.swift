//
//  SessionResponce.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 12/7/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation

// MARK: - SessionResponce
struct SessionResponce: Codable {
    let lastName, firstName: String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
    }
}
