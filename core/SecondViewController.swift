//
//  SecondViewController.swift
//  core
//This ViewController is for Patients list
//
//  Created by Haider Tamsil
//  Copyright © 2021 Haider Tamsil. All rights reserved.
//

import UIKit



protocol DataPass {
    func data(object:[String:String], index: Int, isEdit: Bool)
}
class SecondViewController: UIViewController, UISearchBarDelegate, DataPass,SecondViewControllerDelegate {
    func hideViewInFirstViewController() {
        
            getStartedView.isHidden = true
        
    }
    
    func data(object: [String : String], index: Int, isEdit: Bool) {
        return
    }

    @IBOutlet var getStartedView: UIView!
    
    var drID = ""
    
    
    func setDrID(){
        if Services.ServicesInstance.getToken() != "" {
            drID = Services.ServicesInstance.getToken()
        }
        else{
            drID = APIManager.shareInstance.drID
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destinationVC = segue.destination as? ViewController {
                destinationVC.delegate = self
            }
        }
    
    
    //Deletes patient data
    func deleteData(index:Int) -> [Student]{
        var Student = DatabaseHelper.shareInstance.getAllData()
        Student = arrData.filter{
                   ($0.drID?.contains(drID))!
               }
        
    
        DatabaseHelper.shareInstance.context.delete(Student[index])
        Student.remove(at: index)
        do{
            try  DatabaseHelper.shareInstance.context.save()
        }catch{
            print("Can't delete data")
        }
        return Student
    }
    
    
//    func editData(object:[String:String], i: Int){
//        var Student = DatabaseHelper.shareInstance.getAllData()
//           Student = Student.filter{
//               ($0.drID?.contains(drID))!
//           }
//           
//           Student[i].name = object["name"]
//           Student[i].age = object["age"]
//           Student[i].cnic = object["cnic"]
//           Student[i].contact = object["contact"]
//           Student[i].city = object["city"]
//           
//           
//           do {
//               try DatabaseHelper.shareInstance.context.save()
//           }catch{
//               print("Data is not edited")
//               
//           }
//           
//           
//       }
    
    //refreshes the page
    @IBAction func refresh(_ sender: Any) {
        
        
        let alertView = UIAlertController(title: "", message: "Are you sure you want Logout? ", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            
            Services.ServicesInstance.removedToken()
            
            
            self.present(VC, animated: true, completion: nil)
                       })
                       let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: { (alert) in
                            print("Cancel")
                       })
                       alertView.addAction(okAction)
                       alertView.addAction(cancelAction)
        alertView.view.tintColor = UIColor.black
                       self.present(alertView, animated: true, completion: nil)
        
//        arrData = DatabaseHelper.shareInstance.getAllData()
//        arrData = arrData.filter{
//            ($0.drID?.contains(drID))!
//        }
//        
//        self.tableView.reloadData()
    }
    
    

   //Adds patient and goes to patient form (ViewController)
    @IBAction func add(_ sender: Any) {
        
//        self.getStartedView.isHidden = true
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
           
           self.navigationController?.pushViewController(VC, animated: true)
           
         
        }
    public var student: Student?
    
  
    //This is for search bar
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var tableView: UITableView!
    
    
    var delegate:DataPass!
    var arrData = [Student]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        arrData = DatabaseHelper.shareInstance.getAllData()
        arrData = arrData.filter{
                   ($0.drID?.contains(drID))!
               }
        if let tableView = self.tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        } else {
            print("Error: tableView is nil")
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDrID()
      
        initSearchController()
        
        if let tableView = self.tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        } else {
            print("Error: tableView is nil")
        }
        
        
        arrData = DatabaseHelper.shareInstance.getAllData()
        arrData = arrData.filter {
            ($0.drID?.contains(drID))!
        }
        
        searchBarSetup()
        
        
//        self.tableView.autoresizingMask = UIViewAutoresizing.flexibleHeight;
//        searchbar.delegate= self
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(SecondViewController.longPress(longPressGestureRecognizer:)))
        self.view.addGestureRecognizer(longPressRecognizer)
        
        
        
        
        ShowGetStarted()
    }
    
 
    
    @objc func ShowGetStarted(){
        if arrData.count < 1 {
            getStartedView.isHidden = false
        }
        else{
            getStartedView.isHidden = true
        }
    }
    
    //Longpress for edit
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        arrData = DatabaseHelper.shareInstance.getAllData()
        arrData = arrData.filter{
            ($0.drID?.contains(drID))!
        }
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = longPressGestureRecognizer.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                let data = arrData[indexPath.row]
              
                let dict = ["name":data.name,"city":data.city,"cnic":data.cnic,"contact":data.contact, "age":data.age, "drID":drID]
                
                
                delegate?.data(object: dict as! [String:String], index: indexPath.row, isEdit: true)
                
                
                let formVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                
                formVC.i = indexPath.row
                formVC.isUpdate = true
                formVC.EditLabel = "Edit"
//                formVC.edit.titleLabel?.text = "Edit"
//                formVC.label?.text = "Edit form"
//                formVC.button?.titleLabel?.text = "Edit"
                formVC.data = data
                
                formVC.title = "Edit"
                self.navigationController?.pushViewController(formVC, animated: true)
                
            }
        }
    }
  
    private func searchBarSetup(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    

    @IBAction func edit(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
    }
    
    
}


//Extension for search bar
extension SecondViewController : UISearchResultsUpdating{
  
    func updateSearchResults(for searchController: UISearchController) {
        //later
        guard let searchText = searchController.searchBar.text else { return }
        if searchText == ""{
            arrData = DatabaseHelper.shareInstance.getAllData()
            arrData = arrData.filter{
                ($0.drID?.contains(drID))!
            }
            
        }else{
            arrData = DatabaseHelper.shareInstance.getAllData()
            arrData = arrData.filter{
                           ($0.drID?.contains(drID))!
                       }
            arrData = arrData.filter{
                ($0.name?.contains(searchText))!
                
            }
        }
        tableView.reloadData()
    }
}





extension SecondViewController : UITableViewDelegate, UITableViewDataSource , UISearchControllerDelegate{
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        arrData = arrData.filter{
//                       ($0.drID?.contains(drID))!
//                   }
        
        ShowGetStarted()
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if cell != nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        
//        cell.lblName.text = arrData[indexPath.row].name
//        cell.lblAge.text = arrData[indexPath.row].age! + "yrs"
        cell.textLabel?.text = arrData[indexPath.row].name
        cell.detailTextLabel?.text = arrData[indexPath.row].age
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete{
            let alertView = UIAlertController(title: "", message: "Are you sure you want to delete this Patient and its record? ", preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    
                    
                    
                    self.arrData = DatabaseHelper.shareInstance.getAllData()
                    self.arrData = self.arrData.filter{
                        ($0.drID?.contains(self.drID))!
                           }
                    
                    self.arrData = self.deleteData(index: indexPath.row)
                     self.tableView.deleteRows(at: [indexPath], with: .fade)
                     self.ShowGetStarted()
                })
                let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: { (alert) in
                     print("Cancel")
                })
                alertView.addAction(okAction)
                alertView.addAction(cancelAction)
                alertView.view.tintColor = UIColor.black
                self.present(alertView, animated: true, completion: nil)

        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = arrData[indexPath.row]
        
        
       
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "view") as! CardsViewController
        VC.student = student
        
//        let dict = ["name":arrData[indexPath.row].name,"city":arrData[indexPath.row].city,"cnic":arrData[indexPath.row].cnic,"contact":arrData[indexPath.row].contact, "age":arrData[indexPath.row].age]
//
//        delegate.data(object: dict as! [String:String])
//        self.navigationController?.popViewController(animated: true)
        
        VC.Patient = arrData[indexPath.row].name!
        VC.data = data
        VC.title = data.name
        
        
        self.navigationController?.pushViewController(VC, animated: true)
         
        
    }
    

    
    
  
    func initSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        
    }
    

}
