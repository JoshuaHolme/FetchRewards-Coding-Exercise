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
    let performers: [Performer]
    let venue: Venue
    let shortTitle: String
    let id: Int
    
    private enum CodingKeys: String, CodingKey {
        case title
        case dateTimeLocal = "datetime_local"
        case timeTBD = "time_tbd"
        case dateTBD = "date_tbd"
        case venue
        case performers
        case shortTitle = "short_title"
        case id
    }
    
    // This Function uses the parameters from the API to decide if there is a valid date and time for the event
    // It then outputs the date and time in a format that the user would expect to be displayed.
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: dateTimeLocal)
        var dateString = ""
        
        if dateTBD && !timeTBD{
            dateString = "Estimated: "
            dateFormatter.dateFormat = "EEEE, d MMMM yyyy \nh:mm a"
            dateString.append("\n\(dateFormatter.string(from: date!))")
            
        } else if dateTBD && timeTBD {
            dateString = "Estimated: "
            dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
            dateString.append("\n\(dateFormatter.string(from: date!))\nTime: TBD")
            
        } else if timeTBD {
            dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
            dateString = dateFormatter.string(from: date!)
            dateString.append("\nTime: TBD")
        } else {
            dateFormatter.dateFormat = "EEEE, d MMMM yyyy \nh:mm a"
            dateString = dateFormatter.string(from: date!)
        }
        return dateString
    }
    
    // This function formats the city and state in a format that the user would expect to be displayed.
    func formatLocation() -> String {
        return "\(venue.city), \(venue.state)"
    }
}
