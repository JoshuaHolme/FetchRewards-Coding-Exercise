# FetchRewards Coding Exercise

## Goal
This Project's goal is to create an iOS application that would consume the open-source SeatGeek API and display events to the user. Users would be able to search these events, as well as favorite events that they may be interested in. These favorited events will be saved between app launches, and will be allowed to be unfavorited as well. Tapping on an event in the list will open up a detail view to give the user a better view of the event.

## Overview
This project uses a `UITableView` to display the events in the `MasterViewController` and a `UISearchBar` to allow the user to search the SeatGeek API for different events. To give live updates as the user types, the API is called for each character change that is in the search bar. This was done to make the app feel more responsive, but could also be changed to only search the API when the user taps the `Search` button on the keyboard to cut down on API requests. The `TableView` is populated by fetching the Events from the API in a URLSession and saving them to an array of `Events`, which is an array of the `Event` struct that matches SeatGeek's data model. These events are then displayed in the different cells of the `TableView`. Each `TableViewCell` displays the event name, event location, and event time, along with a photo for the event. Optionally, if the event has been favorited, an icon indicating this will be shown in the top left corner of the event image.

Once an event is selected from the `TableView`, the app will display a `DetailViewController` which will offer the users a better look at the Event information, as well as allow them to favorite the event with the favorite button in the right of the navigation bar. If an event has been favorited, the app will save the event's `id` in Core Data, which will allow the app to save this status between app launches. The app checks against these saved event id's to decide whether or not to indicate with the UI if an event has been favorited.

## Testing
Unit tests were used in this project to verify that the formatting fuctions in the `Event` struct are outputting strings that are correctly formatted. The `formatDate()` is checked against the three possible date and time configurations that it could encounter. 
1. Both the Date and the Time are TBD 
2. The Date is Confirmed, but the Time is TBD
3. Both the Date and Time are confirmed

The `formatLocation()` function is also tested, but since it does not have the different configurations that `formatDate()` has, only one test case was used.

## Building and Running The Application
This project has no dependencies, and supports iOS 12.1+. To run the application, simply clone the repository, open the project file, and build and run to a compatible device.
