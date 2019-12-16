//
//  OnTheMapClient.swift
//  OnTheMap
//
//  Created by Ziyad Alsaeed on 11/9/19.
//  Copyright © 2019 Ziyad Alsaeed. All rights reserved.
//

import Foundation
class OnTheMapClient {
    struct Auth {
        static var lastName = ""
        static var firstName = ""
        static var passowrd = ""
        static var sessionId = ""
        static var userKey = ""
    }
    enum Endpoints {
        
        static let base = "https://onthemap-api.udacity.com/v1/"
        
        case login
        case studentLocation
        case postLocation
        case userData
        case logOut
        
        var stringValue: String{
            switch self{
            case .login: return Endpoints.base + "session"
            case .studentLocation: return Endpoints.base + "StudentLocation?limit=100&order=-updatedAt"
            case .postLocation: return Endpoints.base + "StudentLocation"
            case .userData: return Endpoints.base + "users/" + OnTheMapClient.Auth.sessionId
            case .logOut: return Endpoints.base + "session"
            }
        }
    
    
    var url: URL {
        return URL(string: stringValue)!
    }
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(OnTheMapRespons.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func getUserName()-> Void{
       
        
      let task = URLSession.shared.dataTask(with: OnTheMapClient.Endpoints.userData.url) { (data, response, error) in

      
        guard let data = data else {return}
           let range = (5..<data.count)
           let newData = data.subdata(in: range) /* subset response data! */

        do{
            let userData = try JSONDecoder().decode(SessionResponce.self, from: newData)
            OnTheMapClient.Auth.firstName = userData.firstName
            OnTheMapClient.Auth.lastName = userData.lastName
            
        }
            catch let jsonErr{
                print("ERROR", jsonErr.localizedDescription)
        print("WE DO NOT GET THE INFO!!")
        }
    }
     task.resume()
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = LoginRequest(udacity: Udacity(username: username, password: password))
        taskForPOSTRequest(url: Endpoints.login.url, responseType: RequestTokenResponse.self, body: body) { response, error in
            if let response = response {
                print(response)
                print("login succed")
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(OnTheMapRespons.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        
        return task
    }
    
    class func taskForGETRequestWithRange<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let range = (5..<data.count)
            let newData = data.subdata(in: range) /* subset response data! */
            //
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(OnTheMapRespons.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        
        return task
    }
    
    
    class func getStudentLocation(completion: @escaping ([Result], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.studentLocation.url, responseType: StudenLocationsRequest.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func logout() -> Void {
        var request = URLRequest(url: Endpoints.logOut.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
        
        
    }
    
}
