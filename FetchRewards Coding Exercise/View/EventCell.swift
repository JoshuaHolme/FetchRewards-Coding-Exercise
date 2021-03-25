//
//  EventCell.swift
//  FetchRewards Coding Exercise
//
//  Created by Joshua Holme on 3/23/21.
//

import UIKit
import CoreData

class EventCell: UITableViewCell {
    
    // Static Variable to track Cell Reuse Identifier
    static let identifier = "eventCell"
    
    // Views
    private var labelStackView = UIStackView()
    private var titleLabel = UILabel()
    private var locationLabel = UILabel()
    private var timeLabel = UILabel()
    private var eventImageView = UIImageView()
    private var favoriteImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(labelStackView)
        contentView.addSubview(eventImageView)
        contentView.addSubview(favoriteImageView)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
        // Title Label Setup
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        titleLabel.numberOfLines = 0
        
        // Location Label Setup
        locationLabel.font = UIFont.systemFont(ofSize: 18)
        locationLabel.textColor = .lightGray
        locationLabel.numberOfLines = 0
        
        // Time Label Setup
        timeLabel.font = UIFont.systemFont(ofSize: 18)
        timeLabel.textColor = .lightGray
        timeLabel.numberOfLines = 0
        
        // Event Image View Setup
        eventImageView.layer.cornerRadius = 25.0
        eventImageView.layer.masksToBounds = true
        
        // Favorite Image View Setup
        favoriteImageView.image = UIImage(named: "heartFill")
        favoriteImageView.tintColor = #colorLiteral(red: 0.8418676853, green: 0.3510983884, blue: 0.2924564481, alpha: 1)
        
        // Label Stack View Setup
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(locationLabel)
        labelStackView.addArrangedSubview(timeLabel)
        labelStackView.axis = .vertical
        labelStackView.spacing = 24
        
        // Constraints
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        favoriteImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            eventImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            eventImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            eventImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            eventImageView.heightAnchor.constraint(equalTo: eventImageView.widthAnchor),
            
            favoriteImageView.widthAnchor.constraint(equalTo: eventImageView.widthAnchor, multiplier: 0.33),
            favoriteImageView.heightAnchor.constraint(equalTo: eventImageView.heightAnchor, multiplier: 0.33),
            favoriteImageView.leadingAnchor.constraint(equalTo: eventImageView.leadingAnchor, constant: -6),
            favoriteImageView.topAnchor.constraint(equalTo: eventImageView.topAnchor, constant: -6),
            
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            labelStackView.leadingAnchor.constraint(equalTo: eventImageView.trailingAnchor, constant: 24),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    func setEvent(event: Event, favoritedEventIDs: [NSManagedObject]) {
        
        // Fill in the views with the Event Attributes
        titleLabel.text = event.title
        locationLabel.text = event.formatLocation()
        eventImageView.downloaded(from: event.performers.first!.image)
        eventImageView.contentMode = .scaleAspectFill
        timeLabel.text = event.formatDate()
        
        // Decide if the favorited View should be shown
        var favorited = false
        for eventID in favoritedEventIDs {
            if eventID.value(forKeyPath: "eventID") as? Int == event.id {
                favorited = true
            }
        }
        
        if !favorited {
            favoriteImageView.isHidden = true
        }
        else {
            favoriteImageView.isHidden = false
        }
    }
}
