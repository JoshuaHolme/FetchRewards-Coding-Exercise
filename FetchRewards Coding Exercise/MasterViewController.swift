//
//  MasterViewController.swift
//  FetchRewards Coding Exercise
//
//  Created by Joshua Holme on 3/23/21.
//

import UIKit

class MasterViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    private var events = Events(events: [])
    private var eventsTableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadEvents()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Events
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height

        eventsTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        eventsTableView.rowHeight = UITableView.automaticDimension
        eventsTableView.estimatedRowHeight = 300
        eventsTableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        self.view.addSubview(eventsTableView)
    }

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath as IndexPath) as! EventCell
        cell.setEvent(event: events.events[indexPath.row])
        return cell
    }
}
