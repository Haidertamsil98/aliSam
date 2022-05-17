//
//  RegisterModel.swift
//  core
//
//  Created by Apple on 27/07/2021.
//  Copyright © 2021 Haider Tamsil. All rights reserved.
//

import Foundation

//Registration Model of AWS Cloud

struct Register: Codable{
    let doc_full_name: String
    let hospital_name: String
    let doc_email: String
    let doc_phone: String
    let doc_cnic: String
    let doc_gender: String
    let user_name: String
    let password: String
    let doc_date_added: String
}


//Model For forget of AWS Cloud
struct Forgot: Codable{
    let old_cnic: String
    let new_password: String
    
}


//Model for Response from AWS API
struct responseModel: Codable {
    let doc_id: Int?
    
    private enum CodingKeys: String, CodingKey{
        case doc_id = "doc_id"
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        doc_id = try values.decodeIfPresent(Int.self, forKey: .doc_id)
    }
    
    
}



struct patientRegister : Codable{
    let doctor_fk_id: String
    let pat_full_name: String
    let pat_phone: String
    let pat_cnic: String
    let pat_age: String
    let pat_gender: String
    let pat_date_added : String
}



struct updatePatientModel: Codable {
    
    let pat_full_name: String
    let pat_phone: String
    let pat_cnic: String
    let pat_age: String
    let pat_gender: String
    let pat_id: String

}


struct patientDelete: Codable {
    
    let patient_id: String

}


struct HeartModel: Codable {
    
    let base64_string_of_heart_audio_file : String
    let patient_id : String
    let heart_diagnosis : String

}



struct securedApi: Codable{
    
    let name: String
    
}






struct interceptor: Codable{
    let access_key: String
    let secret_key: String
    
}
