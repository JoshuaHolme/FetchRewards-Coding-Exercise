//
//  EventCell.swift
//  FetchRewards Coding Exercise
//
//  Created by Joshua Holme on 3/23/21.
//

import UIKit

class EventCell: UITableViewCell {
    static let identifier = "eventCell"
    
    private var labelStackView = UIStackView()
    var titleLabel = UILabel()
    var locationLabel = UILabel()
    var timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(labelStackView)
        configureLabelStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLabelStackView() {
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        titleLabel.numberOfLines = 0
        
        locationLabel.font = UIFont.systemFont(ofSize: 18)
        locationLabel.textColor = .lightGray
        locationLabel.numberOfLines = 0
        
        timeLabel.font = UIFont.systemFont(ofSize: 18)
        timeLabel.textColor = .lightGray
        timeLabel.numberOfLines = 0
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(locationLabel)
        labelStackView.addArrangedSubview(timeLabel)
        labelStackView.axis = .vertical
        labelStackView.spacing = 24
        
        // Constraints
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            labelStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            labelStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            labelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    func setEvent(event: Event) {
        titleLabel.text = event.title
        locationLabel.text = "\(event.venue.city), \(event.venue.state)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: event.dateTimeLocal)
        var dateString = ""
        
        if event.dateTBD && !event.timeTBD{
            dateString = "Estimated: "
            dateFormatter.dateFormat = "EEEE, d MMMM yyyy \nh:mm a"
            dateString.append("\n\(dateFormatter.string(from: date!))")
            
        } else if event.dateTBD && event.timeTBD {
            dateString = "Estimated: "
            dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
            dateString.append("\n\(dateFormatter.string(from: date!))\nTime: TBD")
            
        } else if event.timeTBD {
            dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
            dateString = dateFormatter.string(from: date!)
            dateString.append("\nTime: TBD")
        } else {
            dateFormatter.dateFormat = "EEEE, d MMMM yyyy \nh:mm a"
            dateString = dateFormatter.string(from: date!)
        }
        
        timeLabel.text = "\(dateString)"
    }
}
