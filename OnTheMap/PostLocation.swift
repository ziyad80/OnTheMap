//
//  PostLocation.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 12/5/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PostLocation: UIViewController, UISearchBarDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var postLocationMap: MKMapView!
    
   
    
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var mapSearchBar: UISearchBar!
    
    var mapString1: String = ""
    var longitude: Double = 0
    var latitude: Double = 0
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextField.delegate = self
        mapSearchBar.delegate = self
      
        locationManager.delegate = self as CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        urlTextField.text = ""
        
        
        
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(mapSearchBar.text!) { (placemarks: [CLPlacemark]?, error: Error?) in
            if error == nil {
                
                let placemark = placemarks?.first
                let anno = MKPointAnnotation()
                anno.coordinate = (placemark?.location?.coordinate)!
                anno.title = placemark?.locality
                self.postLocationMap.addAnnotation(anno)
                self.postLocationMap.selectAnnotation(anno, animated: true)
                self.mapString1 = placemark?.locality ?? self.mapSearchBar.text!
                self.latitude = (placemark?.location?.coordinate.latitude)!
                self.longitude = (placemark?.location?.coordinate.longitude)!
                
                
            }else{
                print(error?.localizedDescription ?? "ERROR")
            }
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        urlTextField.resignFirstResponder()
        return true
    }
    
    func postingLocation(completion: @escaping (Bool, Error?) -> Void) {
       let post = PostLocationRequest(firstName: OnTheMapClient.Auth.firstName, lastName: OnTheMapClient.Auth.lastName, longitude: longitude, latitude: latitude, mapString: mapString1, mediaURL: urlTextField.text!, uniqueKey: OnTheMapClient.Auth.userKey)
        
        var request = URLRequest(url: URL(string: OnTheMapClient.Endpoints.base + "StudentLocation")!)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(post)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if response != nil {
                completion(true, nil)
                
            } else {
                completion(false, error)
                print(error?.localizedDescription ?? "")
            }
    
   }
        task.resume()
    
    }
    
    
    
    
    
    @IBAction func submitButtum(_ sender: Any) {
        
        postingLocation { (success: Bool, error : Error?) in
            if success{
                self.dismiss(animated: true, completion: nil)
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
        
    }
}


 
extension PostLocation : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
    locationManager.requestLocation()
    }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
       
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }

}
    

