//
//  File.swift
//  core
//
//  Created by Apple on 07/09/2021.
//  Copyright © 2021 Haider Tamsil. All rights reserved.
//

import UIKit


class Services{
    static let ServicesInstance = Services()
    let userDefault = UserDefaults.standard

    func savedToken(token: String){
        userDefault.set(token, forKey: tokenkey.userLogin)
    }


    func getToken() -> String {
        if let token = userDefault.object(forKey: tokenkey.userLogin) as? String{
            return token
        }
        else{
            return ""
        }

    }



    func checkForLogin() -> Bool {
        if getToken() == ""{
            return false
        }
        else {
            return true
        }
    }


    func removedToken(){
        userDefault.removeObject(forKey: tokenkey.userLogin)
    }


}
