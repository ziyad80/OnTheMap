//
//  LocationsTablViewController.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 11/24/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation
import UIKit

class LocationsTablViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = 0
    var studentLocation: [Result]{
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        return appDelegate.results
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        _ = OnTheMapClient.getStudentLocation() { result, error in
            LocationsModel.locations = result
            
            self.tableView.reloadData()
            }
        
        
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        print("viewWillAppear: ", LocationsModel.locations.count)
    }

}
    extension LocationsTablViewController: UITableViewDataSource, UITableViewDelegate {
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("numberOfRowsInSection: ", LocationsModel.locations.count)
            return LocationsModel.locations.count
            
        }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationsTablViewCell", for: indexPath) as! LocationsTablViewCell
        let location = LocationsModel.locations[indexPath.row]
        cell.studentName.text = "\(location.firstName + "  " + location.lastName) ... \(location.mapString)"
        
//        cell.studentLocation.text = location.mapString
       
        return cell
    }
    
    
    
    
    
    
    
}


