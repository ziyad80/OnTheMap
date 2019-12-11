//
//  LocationsTablViewController.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 11/24/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation
import UIKit

class LocationsTablViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    func getData() -> Void {
        
        OnTheMapClient.getStudentLocation() { result, error in
            self.studentLocation = result
            self.tableView.reloadData()
            print("Data Reloded")
        
    
    }
    }
    
    @IBAction func refresh(_ sender: Any) {
        getData()
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var studentLocation: [Result] {
        get {
            return LocationsModel.locations
        }
        set {
            LocationsModel.locations = newValue
        }
    }
//    var studentLocation: [Result]{
//        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
//        return appDelegate.results
//    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        guard self.studentLocation.isEmpty else {
            return
        }
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        print("viewWillAppear: ", studentLocation.count)
    }


    //extension LocationsTablViewController: UITableViewDataSource, UITableViewDelegate {
        
      
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("numberOfRowsInSection ", studentLocation.count)
            return studentLocation.count
            
        }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationsTablViewCell", for: indexPath) as! LocationsTablViewCell
        let location = studentLocation[indexPath.row]
       
       cell.textLabel?.text = "\(location.firstName + " " + location.lastName )"
        cell.detailTextLabel?.text = location.mapString
//        cell.studentName.text = "\(location.firstName + " " + location.lastName ) ... \(location.mapString )"
//
//        cell.studentLocation.text = location.mapString
       
        return cell
    }
    
   
    
    
    
    
    
}


