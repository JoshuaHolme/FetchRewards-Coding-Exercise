//
//  MasterViewController.swift
//  FetchRewards Coding Exercise
//
//  Created by Joshua Holme on 3/23/21.
//

import UIKit
import CoreData

class MasterViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private var events = Events(events: [])                 // Variable to Hold Fetched Events
    private var eventsTableView = UITableView()             // TableView Variable
    private var searchBar: UISearchBar = UISearchBar()      // Search Bar Variable
    private var favoritedEventIDs: [NSManagedObject] = []   // Array of Favorited Event IDs from CoreData
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadEvents()        // Load the events from the SeatGeek API
        loadFavorites()     // Load the favorited Events from Core Data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the TableView
        eventsTableView = UITableView()
        eventsTableView.rowHeight = UITableView.automaticDimension
        eventsTableView.estimatedRowHeight = 300
        eventsTableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        
        // Setup the Search Bar
        searchBar.placeholder = " Search events"
        searchBar.isTranslucent = false
        searchBar.delegate = self
        
        self.view.addSubview(eventsTableView)
        self.view.addSubview(searchBar)
        
        // Constraints
        eventsTableView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            eventsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            eventsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            eventsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            eventsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchEvents(url: createSearchURL(searchText: searchText))
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    // Function to load events from the SeatGeek API
    func loadEvents() {
        guard let url = URL(string: "https://api.seatgeek.com/2/events?client_id=MjE2Mjc0MjZ8MTYxNjUyNjc2Ny4zNjgyODAy") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let eventsData = try decoder.decode(Events.self, from: data)
                self.events = eventsData
                DispatchQueue.main.async {
                    self.eventsTableView.reloadData()
                }
            } catch let err {
                print("Error", err)
            }
        }.resume()
    }
    
    // Function to load favorited events from CoreData
    func loadFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEvent")
        
        do {
            favoritedEventIDs = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // Function to build an API request URL from the Search Bar Text
    func createSearchURL(searchText: String) -> URL {
        var searchQuery = "https://api.seatgeek.com/2/events?client_id=MjE2Mjc0MjZ8MTYxNjUyNjc2Ny4zNjgyODAy&q="
        searchQuery.append(searchText.replacingOccurrences(of: " ", with: "+").lowercased())
        
        return URL(string: searchQuery)!
    }
    
    // Function to search the SeatGeek API
    func searchEvents(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let eventsData = try decoder.decode(Events.self, from: data)
                self.events = eventsData
                DispatchQueue.main.async {
                    self.eventsTableView.reloadData()
                }
            } catch let err {
                print("Error", err)
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.events.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.setEvent(event: events.events[indexPath.row])
        detailViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath as IndexPath) as! EventCell
        
        cell.setEvent(event: events.events[indexPath.row], favoritedEventIDs: favoritedEventIDs)
        return cell
    }
}
