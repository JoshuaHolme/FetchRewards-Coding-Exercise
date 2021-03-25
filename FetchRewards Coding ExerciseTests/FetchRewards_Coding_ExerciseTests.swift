//
//  FetchRewards_Coding_ExerciseTests.swift
//  FetchRewards Coding ExerciseTests
//
//  Created by Joshua Holme on 3/23/21.
//

import XCTest
@testable import FetchRewards_Coding_Exercise

class FetchRewards_Coding_ExerciseTests: XCTestCase {
    
    func testEventFormatDate() throws {
        
        // Test Both Time and Date TDB
        let eventTimeDateTBD = Event(title: "America", dateTimeLocal: "2021-03-25T03:30:00", timeTBD: true, dateTBD: true, performers: [Performer(image: "https://seatgeek.com/images/performers-landscape/america-79ed04/186/15015/huge.jpg")], venue: Venue(name: "Florida Theatre", address: "128 East Forsyth Street", extendedAddress: "Jacksonville, FL 32202", city: "Jacksonville", postalCode: "32202", state: "FL", country: "US", location: ["lat":30.3263,"lon":-81.6557], url: URL(string: "https://seatgeek.com/venues/florida-theatre/tickets")!, score: 0.541829, id: 493), shortTitle: "America", id: 4935201)
        
        XCTAssertEqual(eventTimeDateTBD.formatDate(), "Estimated: \nThursday, 25 March 2021\nTime: TBD")
        
        // Test Confirmed Date but TBD Time
        let eventTimeTBD = Event(title: "America", dateTimeLocal: "2021-03-25T03:30:00", timeTBD: true, dateTBD: false, performers: [Performer(image: "https://seatgeek.com/images/performers-landscape/america-79ed04/186/15015/huge.jpg")], venue: Venue(name: "Florida Theatre", address: "128 East Forsyth Street", extendedAddress: "Jacksonville, FL 32202", city: "Jacksonville", postalCode: "32202", state: "FL", country: "US", location: ["lat":30.3263,"lon":-81.6557], url: URL(string: "https://seatgeek.com/venues/florida-theatre/tickets")!, score: 0.541829, id: 493), shortTitle: "America", id: 4935201)
        
        XCTAssertEqual(eventTimeTBD.formatDate(), "Thursday, 25 March 2021\nTime: TBD")
        
        // Test Both Confirmed Date and Time
        let event = Event(title: "America", dateTimeLocal: "2021-03-25T03:30:00", timeTBD: false, dateTBD: false, performers: [Performer(image: "https://seatgeek.com/images/performers-landscape/america-79ed04/186/15015/huge.jpg")], venue: Venue(name: "Florida Theatre", address: "128 East Forsyth Street", extendedAddress: "Jacksonville, FL 32202", city: "Jacksonville", postalCode: "32202", state: "FL", country: "US", location: ["lat":30.3263,"lon":-81.6557], url: URL(string: "https://seatgeek.com/venues/florida-theatre/tickets")!, score: 0.541829, id: 493), shortTitle: "America", id: 4935201)
        
        XCTAssertEqual(event.formatDate(), "Thursday, 25 March 2021 \n3:30 AM")
    }
    
    func testEventFormatLocation() throws {
        let event = Event(title: "America", dateTimeLocal: "2021-03-25T03:30:00", timeTBD: true, dateTBD: true, performers: [Performer(image: "https://seatgeek.com/images/performers-landscape/america-79ed04/186/15015/huge.jpg")], venue: Venue(name: "Florida Theatre", address: "128 East Forsyth Street", extendedAddress: "Jacksonville, FL 32202", city: "Jacksonville", postalCode: "32202", state: "FL", country: "US", location: ["lat":30.3263,"lon":-81.6557], url: URL(string: "https://seatgeek.com/venues/florida-theatre/tickets")!, score: 0.541829, id: 493), shortTitle: "America", id: 4935201)
        
        XCTAssertEqual(event.formatLocation(), "Jacksonville, FL")
    }
}
