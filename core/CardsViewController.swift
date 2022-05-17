//
//  CardsViewController.swift
//  core
//
//  Created by Apple on 15/04/2021.
//  Copyright © 2021 HaiderTamsil. All rights reserved.
//

import CoreData
import UIKit
import AVFoundation
import AVKit


//protocol DataPass {
//    func data(object:[String:String], index: Int, isEdit: Bool)
//}

class CardsViewController: UIViewController, DataPass {
    func data(object: [String : String], index: Int, isEdit: Bool) {
        return
    }
    
    
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var numberOfRecords = 0
    var audioPlayer: AVAudioPlayer!
    let engine = AVAudioEngine()
    var isPlaying = false
    var delegate: DataPass!
    var Patient = ""
    
  
    func deleteAudioData(index:Int) -> [Audio]{
           var Audio = DatabaseHelper.shareInstance.getAllAudioData()
            Audio = audioArrData.filter{
                ($0.patient?.contains(Patient))!

            }
           
        DatabaseHelper.shareInstance.context.delete(Audio[index])
           Audio.remove(at: index)
           do{
            try  DatabaseHelper.shareInstance.context.save()
           }catch{
               print("Can't delete data")
           }
        
//        audioArrData = audioArrData.filter{
//                       ($0.patient?.contains(Patient))!
//
//                   }
        
         return audioArrData
       }

    
    public var audioData : Audio?
    var audioArrData = [Audio]()
    public var student: Student?
    
    @IBOutlet weak var AudioTableView: UITableView!
    

    
    
    
    public var data: Student?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var cnic: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBAction func addRecording(_ sender: Any) {
        
        
        let recordVC = self.storyboard?.instantiateViewController(withIdentifier: "recordViewController") as! recordViewController
        recordVC.Patient = Patient
        self.present(recordVC, animated: true, completion: nil)
        
//        recordVC.modalPresentationStyle = .overCurrentContext
//        recordVC.modalTransitionStyle = .crossDissolve
//
    }
    var arrData = [Student]()
    
    
    
    @IBAction func refresh(_ sender: Any) {
        audioArrData = DatabaseHelper.shareInstance.getAllAudioData()
        audioArrData = audioArrData.filter{
                   ($0.patient?.contains(Patient))!

               }

        AudioTableView.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
        self.AudioTableView.reloadData()
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        audioArrData = DatabaseHelper.shareInstance.getAllAudioData()
                    audioArrData = audioArrData.filter{
                               ($0.patient?.contains(Patient))!

                           }

                    AudioTableView.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
                    self.AudioTableView.reloadData()
    }
    
    
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        audioArrData = DatabaseHelper.shareInstance.getAllAudioData()
              audioArrData = audioArrData.filter{
                         ($0.patient?.contains(Patient))!

                     }

              AudioTableView.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
              self.AudioTableView.reloadData()
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        audioArrData = DatabaseHelper.shareInstance.getAllAudioData()
        audioArrData = audioArrData.filter{
                   ($0.patient?.contains(Patient))!

               }

        AudioTableView.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
        self.AudioTableView.reloadData()
    }
    
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioArrData = DatabaseHelper.shareInstance.getAllAudioData()
        audioArrData = audioArrData.filter{
            ($0.patient?.contains(Patient))!

        }
            
        
        
        
        name?.text = data?.name
        age?.text = data?.age
        cnic?.text = data?.cnic
        contact?.text = data?.contact
        gender?.text = data?.city
        
        AudioTableView.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(CardsViewController.longPress(longPressGestureRecognizer:)))
               self.view.addGestureRecognizer(longPressRecognizer)
    }
}

func getDirectory() -> URL
          {
                          
                  let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                  let documentDirectory = paths[0]
                  return documentDirectory
                          
          }


extension CardsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            audioArrData = audioArrData.filter{
                        ($0.patient?.contains(Patient))!
                      }
       return  audioArrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = String(audioArrData[indexPath.row].location!) + "_" + String(audioArrData[indexPath.row].position!) + " - " +  String(audioArrData[indexPath.row].diagnosis!)
        
//        cell.detailTextLabel?.text = String(audioArrData[indexPath.row].diagnosis!)
        
        return cell
    }
    
    
    //Editing
    
    
      @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
           
            if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
                let touchPoint = longPressGestureRecognizer.location(in: AudioTableView)
                if let indexPath = AudioTableView.indexPathForRow(at: touchPoint) {
                    let data = audioArrData[indexPath.row]
                  
                    let dict = ["audioPath":data.audioPath,"location":data.location,"position":data.position,"diagnosis":data.diagnosis, "patient":data.patient]
                    
                    
                    
                    
                    delegate?.data(object: dict as! [String:String], index: indexPath.row, isEdit: true)
                    
                    
                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "diagnosisViewController") as! diagnosisViewController
                VC.Patient = audioArrData[indexPath.row].patient
                VC.i = indexPath.row
                VC.isUpdate = true
                VC.Diagnosis = audioArrData[indexPath.row].diagnosis
//                VC.label.text = audioArrData[indexPath.row].diagnosis
                VC.data = data
//                formVC.drID = drID
//                formVC.title = data.name
                VC.filePath = audioArrData[indexPath.row].audioPath
                VC.location = audioArrData[indexPath.row].location
                VC.position = audioArrData[indexPath.row].position
                self.present(VC, animated: true)
                    
                    
                }
            }
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete{
            let alertView = UIAlertController(title: "", message: "Are you sure you want to delete this record? ", preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                    
                    
                    let filemanager = FileManager.default
                    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                                     
                    let url = documentsDirectory.appendingPathComponent("NEW_REC")
                              
                    let path = String(self.audioArrData[indexPath.row].audioPath!)
                    let file = url.appendingPathComponent(path)
                                     
                                     

                    do {
                                         
                        try FileManager.default.removeItem(at: file)
                    }
                    catch{
                    print("sorry")
                        
                    }
                    
                    
                    
                    
                    
                    self.audioArrData = self.deleteAudioData(index: indexPath.row)
//                    print(indexPath.row)
                    self.audioArrData.remove(at: indexPath.row)
                    self.AudioTableView.deleteRows(at: [indexPath], with: .fade)
                    
            
                    
                })
                let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: { (alert) in
                     print("Cancel")
                })
                alertView.addAction(okAction)
                alertView.addAction(cancelAction)
                self.present(alertView, animated: true, completion: nil)

        }
    }
    func loadRecordings() {
           let filemanager = FileManager.default
           let documentsDirectory = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0]
           do {
               let paths = try filemanager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
               for path in paths {
                   let recording = Recording(name: path.lastPathComponent, path: path)
                   
               }
               
           } catch {
               print(error)
           }
       }
    
    
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let filemanager = FileManager.default
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let path = String(audioArrData[indexPath.row].audioPath!)
            print("this is path i selected",path)
            

            let url = documentsDirectory.appendingPathComponent("NEW_REC")
            let file = url.appendingPathComponent(path)
            print("play file",file)
            
            do {

            player = AVPlayer(url: file)
            
           
            playerViewController.player = player
                               //        let activityViewController = UIActivityViewController(activityItems: ["Name To Present to User", getDirectory()], applicationActivities: nil)
                self.present(playerViewController, animated: true, completion: {
                            self.playerViewController.player?.play()


                        })

            //            audioPlayer = try AVAudioPlayer(contentsOf: path)
            //            audioPlayer.play()
            //            isPlaying = true
            //            print(audioPlayer.currentTime)

            //            if audioPlayer.isPlaying{
            //                isPlaying = true
            //                print(audioPlayer.currentTime)
            //            }
            //            else{
            //                isPlaying = false
            //            }

                    }
                    catch{

                    }




            }
    
    
}



