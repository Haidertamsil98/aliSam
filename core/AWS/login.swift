//
//  login.swift
//  core
//
//  Created by Apple on 28/07/2021.
//  Copyright © 2021 Haider Tamsil. All rights reserved.
//

import Foundation


//Login Model for Doctor

struct LoginModel: Codable {
    let email: String
    let password: String
}

//ResponseModel for doctor Login

struct LoginResponseModel: Codable{
      let doc_id: Int?
      
      private enum CodingKeys: String, CodingKey{
          case doc_id = "doc_id"
      }
      
      init(from decoder: Decoder) throws{
          let values = try decoder.container(keyedBy: CodingKeys.self)
          doc_id = try values.decodeIfPresent(Int.self, forKey: .doc_id)
      }
}
