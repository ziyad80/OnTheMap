//
//  ViewController.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 11/9/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    struct LoginRequest: Codable {
//        let udacity: Udacity
//    }
//    
//    // MARK: - Udacity
//    struct Udacity: Codable {
//        let username, password: String
//    }
        
    
    
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        PasswordTextField.text = ""
    }
    func postingASession(username: String, password: String, completion: @escaping (Bool, Error?) -> Void){
        let post = LoginRequest( udacity: Udacity(username: username , password: password ))
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = try! JSONEncoder().encode(post)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let response = response {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            
            do{
               
                      let RequestTokenResponses = try
                       JSONDecoder().decode(RequestTokenResponse.self, from: newData!)
                      print(RequestTokenResponses)
                  }
               catch let jsonErr{
                      print("ERROR", jsonErr)}
            
        }
        
        task.resume()
       
        
    }

    
    @IBAction func loginButtum(_ sender: Any) {
        
       
        postingASession(username: usernameTextField.text ?? "" , password: PasswordTextField.text ?? "") { (success: Bool, error: Error?) in
          
            if success{
                DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
                }
              
                
            } else{
                print("ERROR!!",error?.localizedDescription as Any)
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

