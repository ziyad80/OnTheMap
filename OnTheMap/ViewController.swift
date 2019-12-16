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
        var request = URLRequest(url: OnTheMapClient.Endpoints.login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = try! JSONEncoder().encode(post)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            let httpResponse = response as! HTTPURLResponse;()
            if httpResponse.statusCode <= 299 {
                completion(true, nil)
            } else {
                completion(false, error)
            }
            
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            //print("print Login data: ", String(data: newData!, encoding: .utf8)!)
            do{
               
                      let RequestTokenResponses = try
                       JSONDecoder().decode(RequestTokenResponse.self, from: newData!)
                    OnTheMapClient.Auth.userKey = RequestTokenResponses.account.key
                OnTheMapClient.Auth.sessionId = RequestTokenResponses.session.id
                OnTheMapClient.getUserName()
                 
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
                DispatchQueue.main.async {
                    MessagInfoAlert.showAlert(title: "Login failed", message: "Invalid username or password")
                    print("ERROR!!",error?.localizedDescription as Any)
                }
                
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

