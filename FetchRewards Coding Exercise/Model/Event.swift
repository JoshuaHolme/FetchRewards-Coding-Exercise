//
//  Events.swift
//  FetchRewards Coding Exercise
//
//  Created by Joshua Holme on 3/23/21.
//

import Foundation

struct Event: Codable {
    let title: String
    let dateTimeLocal: String
    let timeTBD: Bool
    let dateTBD: Bool
    let venue: Venue
    let shortTitle: String
    let id: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case dateTimeLocal = "datetime_local"
        case timeTBD = "time_tbd"
        case dateTBD = "date_tbd"
        case venue
        case shortTitle = "short_title"
        case id
    }
}
