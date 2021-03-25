//
//  DetailViewController.swift
//  FetchRewards Coding Exercise
//
//  Created by Joshua Holme on 3/24/21.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    // Event Parameters
    var id: Int = 0
    var eventTitle: String = ""
    var favorited: Bool = false
    var favoritedEventIDs: [NSManagedObject] = []
    var imageURL: String = ""
    var date: String = ""
    var location: String = ""
    
    // Views
    let titleLabel = UILabel()
    let eventImageView = UIImageView()
    let dateLabel = UILabel()
    let locationLabel = UILabel()
    let favoriteButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFavorites()
        
        // Set the background of the view to hide the Master View Controller on transition
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
        // Setup Favorite Button in Navigation Bar
        favoriteButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        favoriteButton.setImage(UIImage(named: favorited ? "heartFill" : "heart"), for:.normal)
        favoriteButton.tintColor = #colorLiteral(red: 0.8418676853, green: 0.3510983884, blue: 0.2924564481, alpha: 1)
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        let favoriteBarButton = UIBarButtonItem(customView: favoriteButton)
        self.navigationItem.rightBarButtonItem = favoriteBarButton
        
        // Setup Event Title Label
        titleLabel.text = eventTitle
        titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        titleLabel.numberOfLines = 0
        
        // Setup Event Image View
        eventImageView.downloaded(from: URL(string: imageURL)!)
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.layer.cornerRadius = 25
        eventImageView.layer.masksToBounds = true
        eventImageView.backgroundColor = .blue
        
        // Setup Event Date Label
        dateLabel.text = date
        dateLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        dateLabel.numberOfLines = 0
        
        // Setup Event Location Label
        locationLabel.text = location
        locationLabel.font = UIFont.systemFont(ofSize: 18)
        locationLabel.textColor = .lightGray
        locationLabel.numberOfLines = 0
        
        view.addSubview(titleLabel)
        view.addSubview(eventImageView)
        view.addSubview(dateLabel)
        view.addSubview(locationLabel)
        
        
        // Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        favoriteBarButton.customView!.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            
            eventImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            eventImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            eventImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            
            dateLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            
            locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            locationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            locationLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            locationLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            
            favoriteBarButton.customView!.widthAnchor.constraint(equalToConstant: 30),
            favoriteBarButton.customView!.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // Function to toggle if an Event has been favorited
    @objc func toggleFavorite() {
        if favorited {
            favoriteButton.setImage(UIImage(named: "heart"), for:.normal)
            deleteFavorite()
            favorited.toggle()
        }
        else {
            favoriteButton.setImage(UIImage(named: "heartFill"), for:.normal)
            saveFavorite()
            favorited.toggle()
        }
    }
    
    // Function to load Favorited Events from CoreData
    func loadFavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEvent")
        
        do {
            favoritedEventIDs = try managedContext.fetch(fetchRequest)
            
            for event in favoritedEventIDs {
                if event.value(forKeyPath: "eventID") as? Int == id {
                    favorited = true
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // Function to save an Event's ID to the Favorited Events in CoreData
    func saveFavorite() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteEvent", in: managedContext)!
        let favoritedEvent = NSManagedObject(entity: entity, insertInto: managedContext)
        favoritedEvent.setValue(id, forKeyPath: "eventID")
        
        do {
            try managedContext.save()
            favoritedEventIDs.append(favoritedEvent)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Function to delete an Event's ID from the Favorited Events in CoreData
    func deleteFavorite() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        for event in favoritedEventIDs {
            if event.value(forKeyPath: "eventID") as? Int == id {
                managedContext.delete(event)
            }
        }
    }
    
    // Function to populate the view with an Event's Values
    public func setEvent(event: Event) {
        id = event.id
        eventTitle = event.title
        imageURL = event.performers.first!.image
        date = event.formatDate()
        location = event.formatLocation()
    }
}
