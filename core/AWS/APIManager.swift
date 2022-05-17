//
//  APIManager.swift
//  core
//
//  Created by Apple on 27/07/2021.
//  Copyright © 2021 Haider Tamsil. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Network
import AWSSigner





//Shows the error message of API
enum APIErrors: Error{
    case custom(message: String)
}

typealias Handler = (Swift.Result<Any?, APIErrors>) -> Void



class APIManager{
    static let shareInstance = APIManager()
//    var dataTask: URLSessionDataTask?
    
//    private var configuration:AWSServiceConfiguration?
//    private var awsCredential = AWSCredential()
//
    
    
    var arrID = [responseModel]()
     
    var drID = ""
    var token = ""
    

    func callingRegisterAPI(register: Register, completionHandler: @escaping (Bool, String) -> ()){
        
        
        let credentials = StaticCredential(accessKeyId: access_keyy, secretAccessKey: secret_keyy)
                      print(credentials)
        let signer = AWSSigner(credentials: credentials, name: "execute-api", region: "us-east-2")
        
        let headers: HTTPHeaders = [
        .contentType("application/json")
        ]
        
        
        let json: [String: Any] = ["full_name":register.doc_full_name,
                                   "hospital_name":register.hospital_name,
                                   "doc_email":register.doc_email,
                                   "doc_phone": register.doc_phone,
                                   "doc_cnic": register.doc_cnic,
                                   "doc_gender": register.doc_gender,
                                   "user_name": register.user_name,
                                   "password": register.password,
                                   "doc_date_added": register.doc_date_added]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let responseString = String(data: jsonData!, encoding: .utf8)
        //        var jsonString = String(data: jsonData! [encoding: .utf8) ?? ""
                
               

        
        let signedURL = signer.signURL(url: URL(string: doctor_register)!,
        method: .POST,
        body: .string(responseString!) ,
        date: Date(), expires: 600)
               
        
        
    
        
        AF.request(doctor_register, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).responseJSON{
            response in debugPrint(response)
            switch response.result{
            case.success(let data):
                
//                    let urlString = doctor_register
//                    guard let url = URL(string: urlString) else {return}
//
//                    URLSession.shared.dataTask(with: url){ (data, response, err) in
//
//                        guard let data = data else {return}
//
//                        let dataAsString = String(data: data,encoding: .utf8)
//                        print("this is 1 ", response)
//                        do{
//                            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//                            print(json)
//
//                        }
//                        catch{
//                            print(error.localizedDescription)
//                            completionHandler(false, "Please try again")
//                        }
//
//
//
//                    }.resume()
                    

                    if response.response?.statusCode == 200{
                        
                        let responseString = response.description
                        let length = responseString.count

                        let ID = responseString[responseString.index(responseString.startIndex, offsetBy: 8)..<responseString.index(responseString.startIndex, offsetBy: length-1)]
                        print(ID)

//                        self.drID = ID
//                        print("Self.drID", self.drID)
                        completionHandler(true, String(ID))
                        
        
//                        completionHandler(true, "Registered Successfully.")
                    }else{
//                        completionHandler(false, "Please try again")
                    }
                
//                }catch{
//                    print(error.localizedDescription)
//                    completionHandler(false, "Please try again. I hate me")
//                }
            case.failure(let err):
                print(err.localizedDescription)
                completionHandler(false, "Please try again")
            }
        }
    }
    
    func callingLoginAPI(login: LoginModel,completionHandler: @escaping (Bool, String) -> ()){
        
        let credentials = StaticCredential(accessKeyId: access_keyy, secretAccessKey: secret_keyy)
               print(credentials)
        let signer = AWSSigner(credentials: credentials, name: "execute-api", region: "us-east-2")
        
        let headers: HTTPHeaders = [
        .contentType("application/json")
        ]
        
        
        let json: [String: Any] = ["email":login.email,
                                   "password":login.password]

       let jsonData = try? JSONSerialization.data(withJSONObject: json)
          let responseString = String(data: jsonData!, encoding: .utf8)
//        var jsonString = String(data: jsonData! [encoding: .utf8) ?? ""
        
       
        let signedURL = signer.signURL(url: URL(string: doctor_login)!,
        method: .POST,
        body: .string(responseString!) ,
        date: Date(), expires: 600)
        
        
        
        
        
        AF.request(signedURL, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).responseJSON{
            response in debugPrint(response)
            
            
            
//            if response.data != nil {
//
//                do {
//                    let json = try JSONDecoder().decode(responseModel.self, from: response.data!)
//                print("this is json: " , json)
//                }
//                catch{
//                    print(error.localizedDescription)
//                }
//
//
//
//            }
//
            switch response.result{
            case.success(let data):
//                let urlString = doctor_login
//                guard let url = URL(string: urlString) else {return}
//
//                URLSession.shared.dataTask(with: url){ (data, response, err) in
//                    guard let data = data else {return}
//                    let dataAsString = String(data: data,encoding: .utf8)
//                    print("this is response: ", response)
//                    do{
//                        let json = try JSONDecoder().decode(LoginResponseModel.self, from: data)
//                    print("this is res", json)
//                    print("json")
//                }
//                    catch{
//                            print(error.localizedDescription)
//                            completionHandler(false, "Login not Done")
//                            print("not done")
//                        }
//                }.resume()

                if response.response?.statusCode == 200
                {

//                    completionHandler(true, "Login Done")
                    print("done")
//
                    let responseString = response.description
                    let length = responseString.count

                    let ID = responseString[responseString.index(responseString.startIndex, offsetBy: 8)..<responseString.index(responseString.startIndex, offsetBy: length-1)]
                    print(ID)
                    self.drID = String(ID)
                    print("Self.drID", self.drID)
                    completionHandler(true, String(ID))
                    
//                    self.token = response.response?.allHeaderFields["x-amzn-requestid"] as! String
//
                    Services.ServicesInstance.savedToken(token: self.drID)
                   

                }
                else{
                    completionHandler(false, "Please try again")
                    print("not done")
                }


            case.failure(let err):
                print("that")
                print(err.localizedDescription)
               completionHandler(false, "Try Again")
            }
        }
    }
    

    
    func callingForgotPasswordAPI(register: Forgot, completionHandler: @escaping (Bool, String) -> ()){
        let headers: HTTPHeaders = [
        .contentType("application/json")
        ]
        
        
         
               let credentials = StaticCredential(accessKeyId: access_keyy, secretAccessKey: secret_keyy)
                             print(credentials)
               let signer = AWSSigner(credentials: credentials, name: "execute-api", region: "us-east-2")
               
               
               
               
        let json: [String: Any] = ["old_cnic": register.old_cnic,
                                   "new_password": register.new_password]

               let jsonData = try? JSONSerialization.data(withJSONObject: json)
               let responseString = String(data: jsonData!, encoding: .utf8)
               //        var jsonString = String(data: jsonData! [encoding: .utf8) ?? ""
                       
                      

               
               let signedURL = signer.signURL(url: URL(string: forgot_password)!,
               method: .POST,
               body: .string(responseString!) ,
               date: Date(), expires: 600)
        
    
        AF.request(signedURL, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).responseJSON{
            response in debugPrint(response)
            switch response.result{
            case.success(let data):
                if response.response?.statusCode == 200
                {
                    let responseString = response.description
                    let length = responseString.count

                    let ID = responseString[responseString.index(responseString.startIndex, offsetBy: 8)..<responseString.index(responseString.startIndex, offsetBy: length-1)]
                    print(ID)

                    completionHandler(true, String(ID))
                    
                    
                    
                }
                else{
                    completionHandler(false, "Please try again")
                    print("not done")
                }
                   
    
                
            case.failure(let err):
            print("that")
            print(err.localizedDescription)
            completionHandler(false, "Try Again")
            }
        }
}

    
    
    func hitLoginAPI() {
        let credentials = StaticCredential(accessKeyId: access_keyy, secretAccessKey: secret_keyy)
        let signer = AWSSigner(credentials: credentials, name: "execute-api", region: "us-east-2")

        
        
        let json: [String: Any] = ["email": LoginViewController.shareInstance.email,
                                   "password": LoginViewController.shareInstance.password]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        var jsonString = String(data: jsonData!, encoding: .utf8) ?? ""
        
        let signedURL = signer.signURL(url: URL(string: doctor_login)!,
            method: .POST,
            body: .string(jsonString),
            date: Date(), expires: 600)
        
        
        var request = URLRequest(url: signedURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }

        task.resume()
    }
    
    
    
    
    
    
    
//     func PatientRegister(register:patientRegister , completionHandler: @escaping (Bool, String) -> ()){
//            
//        let credentials = StaticCredential(accessKeyId: access_keyy, secretAccessKey: secret_keyy)
//                      print(credentials)
//        let signer = AWSSigner(credentials: credentials, name: "execute-api", region: "us-east-2")
//        
//        let headers: HTTPHeaders = [
//        .contentType("application/json")
//        ]
//        
//        
////        let json: [String: Any] = [
////            "doctor": patientRegister.doctor_fk_id,
////            "full_name": patientRegister.pat_full_name,
////            "pat_phone": patientRegister.pat_phone,
////            "pat_cnic": patientRegister.pat_cnic,
////            "pat_age": patientRegister.pat_age,
////            "pat_gender": patientRegister.pat_gender,
////            "pat_date_added": String.self ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: [patientRegister].self)
//        let responseString = String(data: jsonData!, encoding: .utf8)
//        //        var jsonString = String(data: jsonData! [encoding: .utf8) ?? ""
//                
//               
//
//        
//        let signedURL = signer.signURL(url: URL(string: patient_register)!,
//        method: .POST,
//        body: .string(responseString!) ,
//        date: Date(), expires: 600)
//        
//            AF.request(signedURL, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).responseJSON{
//                response in debugPrint(response)
//                switch response.result{
//                case.success(let data):
//                    
//    //                    let urlString = doctor_register
//    //                    guard let url = URL(string: urlString) else {return}
//    //
//    //                    URLSession.shared.dataTask(with: url){ (data, response, err) in
//    //
//    //                        guard let data = data else {return}
//    //
//    //                        let dataAsString = String(data: data,encoding: .utf8)
//    //                        print("this is 1 ", response)
//    //                        do{
//    //                            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//    //                            print(json)
//    //
//    //                        }
//    //                        catch{
//    //                            print(error.localizedDescription)
//    //                            completionHandler(false, "Please try again")
//    //                        }
//    //
//    //
//    //
//    //                    }.resume()
//                        
//
//                        if response.response?.statusCode == 200{
//                            
//                            let responseString = response.description
//                            let length = responseString.count
//
//                            let ID = responseString[responseString.index(responseString.startIndex, offsetBy: 8)..<responseString.index(responseString.startIndex, offsetBy: length-1)]
//                            print(ID)
//
//                            completionHandler(true, String(ID))
//                            
//                           
//                            
//    //                        completionHandler(true, "Registered Successfully.")
//                        }else{
//    //                        completionHandler(false, "Please try again")
//                        }
//                    
//    //                }catch{
//    //                    print(error.localizedDescription)
//    //                    completionHandler(false, "Please try again. I hate me")
//    //                }
//                case.failure(let err):
//                    print(err.localizedDescription)
//                    completionHandler(false, "Please try again")
//                }
//            }
//        }
//    
//    
    
    
    
    
//     func secure(register: securedApi, completionHandler: @escaping (Bool, String) -> ()){
//        
//        var url = URL(string: secure_API)
//        var request = URLRequest(url: url!)
//        request.setValue("AKIA6KJHO2RDTIUJA4MC", forHTTPHeaderField: "Credential")
//        request.setValue("EDxmaft4Nfe0G24NWq0rdHiTWVog5qShgJ3zXy+r", forHTTPHeaderField: "Authorization")
//        request.setValue("execute-api", forHTTPHeaderField: "API_GATEWAY_SERVICE_NAME")
//        request.setValue("us-east-2", forHTTPHeaderField: "region")
//        
//    
//    
//        
//        URLSession.shared.dataTask(with: request){(data,
//            response, error) in
//            if let data = data{
//                if let jsonString = String(data: data,
//                                           encoding: .utf8)
//                {
//                    
//                    
//                    print(response)
//                    print(jsonString)
//                }
//                else{
//                    print(error)
//                }
//            }
//                                                   
//                                                   
//                                                   
//        }.resume()
//    
//    
//}

    
    
//    func PatientAPI(register: patientRegister, completionHandler: @escaping (Bool, String) -> ()){
//            let headers: HTTPHeaders = [
//            .contentType("application/json")
//            ]
//
//          let credentials = StaticCredential(accessKeyId: access_keyy, secretAccessKey: secret_keyy)
//                              print(credentials)
//            let signer = AWSSigner(credentials: credentials, name: "execute-api", region: "us-east-2")
//
//
//
//        //        let json: [String: Any] = [
//        //            "doctor": patientRegister.doctor_fk_id,
//        //            "full_name": patientRegister.pat_full_name,
//        //            "pat_phone": patientRegister.pat_phone,
//        //            "pat_cnic": patientRegister.pat_cnic,
//        //            "pat_age": patientRegister.pat_age,
//        //            "pat_gender": patientRegister.pat_gender,
//        //            "pat_date_added": String.self ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: patientRegister.self)
//        let responseString = String(data: jsonData!, encoding: .utf8)
//                //        var jsonString = String(data: jsonData! [encoding: .utf8) ?? ""
//
//
//
//
//                let signedURL = signer.signURL(url: URL(string: patient_register)!,
//                method: .POST,
//                body: .string(responseString!) ,
//                date: Date(), expires: 600)
//
//
//
//
//            AF.request(signedURL, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).responseJSON{
//                response in debugPrint(response)
//                switch response.result{
//                case.success(let data):
//
//    //                    let urlString = doctor_register
//    //                    guard let url = URL(string: urlString) else {return}
//    //
//    //                    URLSession.shared.dataTask(with: url){ (data, response, err) in
//    //
//    //                        guard let data = data else {return}
//    //
//    //                        let dataAsString = String(data: data,encoding: .utf8)
//    //                        print("this is 1 ", response)
//    //                        do{
//    //                            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//    //                            print(json)
//    //
//    //                        }
//    //                        catch{
//    //                            print(error.localizedDescription)
//    //                            completionHandler(false, "Please try again")
//    //                        }
//    //
//    //
//    //
//    //                    }.resume()
//
//
//                        if response.response?.statusCode == 200{
//
//                            let responseString = response.description
//                            let length = responseString.count
//
//                            let ID = responseString[responseString.index(responseString.startIndex, offsetBy: 8)..<responseString.index(responseString.startIndex, offsetBy: length-1)]
//                            print(ID)
//
//    //                        self.drID = ID
//    //                        print("Self.drID", self.drID)
//                            completionHandler(true, String(ID))
//
//
//    //                        completionHandler(true, "Registered Successfully.")
//                        }else{
//    //                        completionHandler(false, "Please try again")
//                        }
//
//    //                }catch{
//    //                    print(error.localizedDescription)
//    //                    completionHandler(false, "Please try again. I hate me")
//    //                }
//                case.failure(let err):
//                    print(err.localizedDescription)
//                    completionHandler(false, "Please try again")
//                }
//            }
//        }

    
    
    
    func patientAPI(login: patientRegister,completionHandler: @escaping (Bool, String) -> ()){
            
            let credentials = StaticCredential(accessKeyId: access_keyy, secretAccessKey: secret_keyy)
//                   print(credentials)
            let signer = AWSSigner(credentials: credentials, name: "execute-api", region: "us-east-2")
            
            let headers: HTTPHeaders = [
            .contentType("application/json")
            ]
            
            
            let json: [String: Any] = ["id":login.doctor_fk_id,
                                       "name":login.pat_full_name,
                                       "phone":login.pat_phone,
                                       "cnic":login.pat_cnic,
                                       "age":login.pat_age,
                                       "gender":login.pat_gender,
                                       "date":login.pat_date_added]
        
        
    

           let jsonData = try? JSONSerialization.data(withJSONObject: json)
              let responseString = String(data: jsonData!, encoding: .utf8)
    //        var jsonString = String(data: jsonData! [encoding: .utf8) ?? ""
            
           
            let signedURL = signer.signURL(url: URL(string: patient_register)!,
            method: .POST,
            body: .string(responseString!) ,
            date: Date(), expires: 600)
            
            
            
            
            
            AF.request(signedURL, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).responseJSON{
                response in debugPrint(response)
                
                
                
    //            if response.data != nil {
    //
    //                do {
    //                    let json = try JSONDecoder().decode(responseModel.self, from: response.data!)
    //                print("this is json: " , json)
    //                }
    //                catch{
    //                    print(error.localizedDescription)
    //                }
    //
    //
    //
    //            }
    //
                switch response.result{
                case.success(let data):
    //                let urlString = doctor_login
    //                guard let url = URL(string: urlString) else {return}
    //
    //                URLSession.shared.dataTask(with: url){ (data, response, err) in
    //                    guard let data = data else {return}
    //                    let dataAsString = String(data: data,encoding: .utf8)
    //                    print("this is response: ", response)
    //                    do{
    //                        let json = try JSONDecoder().decode(LoginResponseModel.self, from: data)
    //                    print("this is res", json)
    //                    print("json")
    //                }
    //                    catch{
    //                            print(error.localizedDescription)
    //                            completionHandler(false, "Login not Done")
    //                            print("not done")
    //                        }
    //                }.resume()

                    if response.response?.statusCode == 200
                    {

    //                    completionHandler(true, "Login Done")
                        print("done")
    //
                        let responseString = response.description
                        let length = responseString.count

                        let ID = responseString[responseString.index(responseString.startIndex, offsetBy: 8)..<responseString.index(responseString.startIndex, offsetBy: length-1)]
                        print(ID)
                        self.drID = String(ID)
                        print("Self.drID", self.drID)
                        completionHandler(true, String(ID))
                        
    //                    self.token = response.response?.allHeaderFields["x-amzn-requestid"] as! String
    //
                        Services.ServicesInstance.savedToken(token: self.drID)
                       

                    }
                    else{
                        completionHandler(false, "Please try again")
                        print("not done")
                    }


                case.failure(let err):
                    print("that")
                    print(err.localizedDescription)
                   completionHandler(false, "Try Again")
                }
            }
        }
    
    
    
    func monitor_network() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    

                }
                
            }
            else{
                 DispatchQueue.main.async {
                                  
                               }
            }
        }
        
        
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    
    
    
    
    
//    func hitthatReq(parameter:LoginModel) {
//
//
//            let credentials = StaticCredential(accessKeyId: access_key, secretAccessKey: secret_key)
//                        let signer = AWSSigner(credentials: credentials, name: "execute-api", region: "us-east-2")
//                        let signedURL = signer.signURL(
//                           url: URL(string:doctor_login)!, method: .POST)
//
//           //        let parameters: [String: Any] = [
//           //            "id": 13,
//           //            "name": "Jack & Jill"
//           //        ]
//         let headers: HTTPHeaders = [
//                   .contentType("application/json")
//                   ]
//
//
//
//
//
//
//
//
////            var request = URLRequest(url: signedURL)
////            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
////            request.httpMethod = "POST"
////        let data = try! JSONSerialization.data(withJSONObject: [LoginModel.self], options: JSONSerialization.WritingOptions.prettyPrinted)
////
////        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
////        if let json = json {
////            print(json)
////        }
////        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
////
////
////
//////            let param = parameter
//////        request.httpBody = param.percent
////
//////          do {
//////            request.httpBody = try JSONSerialization.data(withJSONObject: [LoginModel.self], options:.sortedKeys) // pass dictionary to nsdata object and set it as request body
//////             } catch let error {
//////                 print(error.localizedDescription)
//////             }
////
////
////            let task = URLSession.shared.dataTask(with: request) { data, response, error in
////                guard let data = data,
////                    let response = response as? HTTPURLResponse,
////                    error == nil else {                                              // check for fundamental networking error
////                    print("error", error ?? "Unknown error")
////                    return
////                }
////
////                guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
////                    print("statusCode should be 2xx, but is \(response.statusCode)")
////                    print("response = \(response)")
////                    return
////                }
////
////                let responseString = String(data: data, encoding: .utf8)
////                print("responseString = \(responseString)")
////            }
////
////            task.resume()
//        }
//

    
    
    
    
    
    
    
    
    
    func securedAPI(register: securedApi, completionHandler: @escaping (Bool, String) -> ()){
               let headers: HTTPHeaders = [
               .contentType("application/json")
               ]
        
            let credentials = StaticCredential(accessKeyId: access_keyy, secretAccessKey: secret_keyy)
            let signer = AWSSigner(credentials: credentials, name: "execute-api", region: "us-east-2")
            let signedURL = signer.signURL(
               url: URL(string:doctor_login )!, method: .POST)
        
        
        
               
               AF.request(signedURL, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: headers).responseJSON{
                   response in debugPrint(response)
                   switch response.result{
                   case.success(let data):
                       
       //                    let urlString = doctor_register
       //                    guard let url = URL(string: urlString) else {return}
       //
       //                    URLSession.shared.dataTask(with: url){ (data, response, err) in
       //
       //                        guard let data = data else {return}
       //
       //                        let dataAsString = String(data: data,encoding: .utf8)
       //                        print("this is 1 ", response)
       //                        do{
       //                            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
       //                            print(json)
       //
       //                        }
       //                        catch{
       //                            print(error.localizedDescription)
       //                            completionHandler(false, "Please try again")
       //                        }
       //
       //
       //
       //                    }.resume()
                           

                           if response.response?.statusCode == 200{
                               
                               let responseString = response.description
                               let length = responseString.count

                               let ID = responseString[responseString.index(responseString.startIndex, offsetBy: 8)..<responseString.index(responseString.startIndex, offsetBy: length-1)]
                               print(ID)

       //                        self.drID = ID
       //                        print("Self.drID", self.drID)
                               completionHandler(true, String(ID))
                               
               
       //                        completionHandler(true, "Registered Successfully.")
                           }else{
       //                        completionHandler(false, "Please try again")
                           }
                       
       //                }catch{
       //                    print(error.localizedDescription)
       //                    completionHandler(false, "Please try again. I hate me")
       //                }
                   case.failure(let err):
                       print(err.localizedDescription)
                       completionHandler(false, "Please try again")
                   }
               }
           }
    
    
   
    
    
    
     func heartAPI(login: HeartModel,completionHandler: @escaping (Bool, String) -> ()){
                
                let credentials = StaticCredential(accessKeyId: access_keyy, secretAccessKey: secret_keyy)
    //                   print(credentials)
                let signer = AWSSigner(credentials: credentials, name: "execute-api", region: "us-east-2")
                
                let headers: HTTPHeaders = [
                .contentType("application/json")
                ]
                
                
        let json: [String: Any] = ["audioFile":login.base64_string_of_heart_audio_file,
                                   "heartDiagnosis":login.patient_id,
                                   "p_id":login.heart_diagnosis]
            
            
        

               let jsonData = try? JSONSerialization.data(withJSONObject: json)
                  let responseString = String(data: jsonData!, encoding: .utf8)
       
                
               
                let signedURL = signer.signURL(url: URL(string: patient_recording)!,
                method: .POST,
                body: .string(responseString!) ,
                date: Date(), expires: 600)
                
                
                
                
                
                AF.request(signedURL, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).responseJSON{
                    response in debugPrint(response)
                    
                    
                    
        //            if response.data != nil {
        //
        //                do {
        //                    let json = try JSONDecoder().decode(responseModel.self, from: response.data!)
        //                print("this is json: " , json)
        //                }
        //                catch{
        //                    print(error.localizedDescription)
        //                }
        //
        //
        //
        //            }
        //
                    switch response.result{
                    case.success(let data):
        //                let urlString = doctor_login
        //                guard let url = URL(string: urlString) else {return}
        //
        //                URLSession.shared.dataTask(with: url){ (data, response, err) in
        //                    guard let data = data else {return}
        //                    let dataAsString = String(data: data,encoding: .utf8)
        //                    print("this is response: ", response)
        //                    do{
        //                        let json = try JSONDecoder().decode(LoginResponseModel.self, from: data)
        //                    print("this is res", json)
        //                    print("json")
        //                }
        //                    catch{
        //                            print(error.localizedDescription)
        //                            completionHandler(false, "Login not Done")
        //                            print("not done")
        //                        }
        //                }.resume()

                        if response.response?.statusCode == 200
                        {

        //                    completionHandler(true, "Login Done")
                            print("done")
        //
                            let responseString = response.description
                            let length = responseString.count

                            let ID = responseString[responseString.index(responseString.startIndex, offsetBy: 8)..<responseString.index(responseString.startIndex, offsetBy: length-1)]
                            print(ID)
                            self.drID = String(ID)
                            print("Self.drID", self.drID)
                            completionHandler(true, String(ID))
                            
        //                    self.token = response.response?.allHeaderFields["x-amzn-requestid"] as! String
        //
                            Services.ServicesInstance.savedToken(token: self.drID)
                           

                        }
                        else{
                            completionHandler(false, "Please try again")
                            print("not done")
                        }


                    case.failure(let err):
                        print("that")
                        print(err.localizedDescription)
                       completionHandler(false, "Try Again")
                    }
                }
            }
    
    
    
    
    
    
    
    
    
    func updatePatient(login: updatePatientModel,completionHandler: @escaping (Bool, String) -> ()){
                
                let credentials = StaticCredential(accessKeyId: access_keyy, secretAccessKey: secret_keyy)
    //                   print(credentials)
                let signer = AWSSigner(credentials: credentials, name: "execute-api", region: "us-east-2")
                
                let headers: HTTPHeaders = [
                .contentType("application/json")
                ]
                
                
        let json: [String: Any] = [
            "Age":login.pat_age,
            "cnic":login.pat_cnic,
            "fullname":login.pat_full_name,
            "gender":login.pat_gender,
            "id":login.pat_id,
            "phone":login.pat_phone
        ]
            
            
            
        

               let jsonData = try? JSONSerialization.data(withJSONObject: json)
                let responseString = String(data: jsonData!, encoding: .utf8)
       
                
               
                let signedURL = signer.signURL(url: URL(string: patient_update)!,
                method: .POST,
                body: .string(responseString!) ,
                date: Date(), expires: 600)
                
                
                
                
                
                AF.request(signedURL, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers).responseJSON{
                    response in debugPrint(response)
                    
                    
                    
        //            if response.data != nil {
        //
        //                do {
        //                    let json = try JSONDecoder().decode(responseModel.self, from: response.data!)
        //                print("this is json: " , json)
        //                }
        //                catch{
        //                    print(error.localizedDescription)
        //                }
        //
        //
        //
        //            }
        //
                    switch response.result{
                    case.success(let data):
        //                let urlString = doctor_login
        //                guard let url = URL(string: urlString) else {return}
        //
        //                URLSession.shared.dataTask(with: url){ (data, response, err) in
        //                    guard let data = data else {return}
        //                    let dataAsString = String(data: data,encoding: .utf8)
        //                    print("this is response: ", response)
        //                    do{
        //                        let json = try JSONDecoder().decode(LoginResponseModel.self, from: data)
        //                    print("this is res", json)
        //                    print("json")
        //                }
        //                    catch{
        //                            print(error.localizedDescription)
        //                            completionHandler(false, "Login not Done")
        //                            print("not done")
        //                        }
        //                }.resume()

                        if response.response?.statusCode == 200
                        {

        //                    completionHandler(true, "Login Done")
                            print("done")
        //
                            let responseString = response.description
                            let length = responseString.count

                            let ID = responseString[responseString.index(responseString.startIndex, offsetBy: 8)..<responseString.index(responseString.startIndex, offsetBy: length-1)]
                            print(ID)
                            self.drID = String(ID)
                            print("Self.drID", self.drID)
                            completionHandler(true, String(ID))
                            
        //                    self.token = response.response?.allHeaderFields["x-amzn-requestid"] as! String
        //
                            Services.ServicesInstance.savedToken(token: self.drID)
                           

                        }
                        else{
                            completionHandler(false, "Please try again")
                            print("not done")
                        }


                    case.failure(let err):
                        print("that")
                        print(err.localizedDescription)
                       completionHandler(false, "Try Again")
                    }
                }
            }
    
    
    
    
    
    
    
    
    
    
    
    
}


extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
