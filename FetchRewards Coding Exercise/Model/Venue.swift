//
//  Venue.swift
//  FetchRewards Coding Exercise
//
//  Created by Joshua Holme on 3/23/21.
//

import Foundation

struct Venue: Codable {
    let name: String
    let address: String
    let extendedAddress: String
    let city: String
    let postalCode: String
    let state: String
    let country: String
    let location: [String: Double]
    let url: URL
    let score: Double
    let id: Int
    
    private enum CodingKeys: String, CodingKey {
        case name
        case address
        case extendedAddress = "extended_address"
        case city
        case postalCode = "postal_code"
        case state
        case country
        case location
        case url
        case score
        case id
    }
}
