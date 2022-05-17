//
//  DatabaseHelper.swift
//  core
//local database for all queries
//  Created by Haider Tamsil
//  Copyright © Haider Tamsil. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper{
    
    static let shareInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(object:[String:String]){
        let entityName = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context) as! Student
        entityName.name = object["name"]
        entityName.city = object["city"]
        entityName.cnic = object["cnic"]
        entityName.contact = object["contact"]
        entityName.age = object["age"]
        entityName.drID = object["drID"]
        
        do{
            try context.save()
        }catch{
            print("Data not save")
        }
        
    }
    func getAllData() -> [Student]{
        var student:[Student] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Student")
        do{
            student = try context.fetch(fetchRequest) as! [Student]
        }catch{
            print("Not get data")
        }
        return student
    }
    
   
    
    
//    func deleteData(index:Int) -> [Student]{
//        var Student = getAllData()
//
//        context.delete(Student[index])
//        Student.remove(at: index)
//        do{
//            try context.save()
//        }catch{
//            print("Can't delete data")
//        }
//        return Student
//    }
    
    
//    func editData(object:[String:String], i: Int){
//        let Student = getAllData()
//        
//        Student[i].name = object["name"]
//        Student[i].age = object["age"]
//        Student[i].cnic = object["cnic"]
//        Student[i].contact = object["contact"]
//        Student[i].city = object["city"]
//        
//        
//        do {
//            try context.save()
//        }catch{
//            print("Data is not edited")
//            
//        }
//        
//        
//    }
    
//
    func saveAudio(object:[String:String]){
             let audio = NSEntityDescription.insertNewObject(forEntityName: "Audio", into: context) as! Audio
        audio.audioPath = object["path"]
        audio.location = object["location"]
        audio.position = object["position"]
        audio.diagnosis = object["diagnosis"]
        audio.patient = object["patient"]
        
        
              do{
                 try context.save()
             }catch{
                 print("Data not save")
             }

     }
    
    
    
//    func saveAudio(object:[String:String]){
//    let Audio = NSEntityDescription.insertNewObject(forEntityName: "Audio", into: context) as! Doctor
//
//
//
//
//
//                do{
//                    try context.save()
//                }catch{
//                    print("Data not save")
//                }
//
//        }
    
    
    
    
  
    
    
    
//    func saveDoctor(object:[String:String]){
//              let doctor = NSEntityDescription.insertNewObject(forEntityName: "Doctor", into: context) as! Doctor
//        doctor.
//
//
//              do{
//                  try context.save()
//              }catch{
//                  print("Data not save")
//              }
//
//          }
//
    
    
    func getAllAudioData() -> [Audio]{
           var audio:[Audio] = []
           let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Audio")
           do{
               audio = try context.fetch(fetchRequest) as! [Audio]
           }catch{
               print("Not get data")
           }
           return audio
       }
    
    
    
}
