////
////  recordingViewController.swift
////  core
////
////  Created by Apple on 10/06/2021.
////  Copyright © 2021 Yogesh Patel. All rights reserved.
////
//
//import UIKit
//import CoreData
//import AVFoundation
//import AVKit
//let keyID = "key"
//
//
//class recordingViewController: UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {
//
//
//    //Setting Up our table vieww
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return numberOfRecords
//    }
//
//
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
//        cell.textLabel?.text = String(indexPath.row + 1)
//        return cell
//
//    }
//
//    //visualiser function
//
//
////    fileprivate func setupAudioView() {
////        var defaultFrame: CGRect = CGRect(x: 0, y: 24, width: recorderView.frame.width, height: 135)
////        defaultFrame = self.recorderView.frame
////
////
////        audioView.frame = CGRect(x: 0, y: 24, width: recorderView.frame.width, height: 135)
////        recorderView.addSubview(audioView)
////        //TODO: Add autolayout constraints
////
////
////        audioView.alpha = 1
////        audioView.isHidden = false
////
//////        visualiser.gradientStartColor = .white
////
////    }
////
////
//
//
////    var recordButton: UIButton!
////    var audioView = visualiser()
//    var player = AVPlayer()
//    var playerViewController = AVPlayerViewController()
//    var recordingSession: AVAudioSession!
//    var audioRecorder: AVAudioRecorder!
//    var numberOfRecords = 0
//    var audioPlayer: AVAudioPlayer!
//    let engine = AVAudioEngine()
//    var isPlaying = false
//
//
//    @IBOutlet weak var recorderView: UIView!
//
//
//
////    @IBOutlet weak var recorderView: UIView!
//
//
//    @IBOutlet weak var buttonLabel: UIButton!
//
//    @IBOutlet weak var myTableView: UITableView!
//
//    @IBAction func record(_ sender: Any) {
//
////        let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
//
//
//
//
//        //Check if we have an active recorder
//        if audioRecorder == nil{
//             numberOfRecords += 1
//
//            //Timer to find current time of audio
//            let filename = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
//
//            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
//
//            //Start Audio Recording
//            do{
//                audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
//                audioRecorder.delegate = self
//                audioRecorder.record()
//
//                buttonLabel.setTitle("Stop Recording", for: .normal)
//
//            }
//            catch{
//                displayAlert(title: "Oops!", message: "Recording Failed")
//            }
//        }
//
//        else{
//            //stopRecording
//            audioRecorder.stop()
//            audioRecorder = nil
//
//            UserDefaults.standard.set(numberOfRecords, forKey: "myNumber")
//            myTableView.reloadData()
//
//            buttonLabel.setTitle("Start Recording", for: .normal)
//
//        }
//
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        print("This is",getDirectory())
//        // Do any additional setup after loading the view.
//        recordingSession = AVAudioSession.sharedInstance()
//        do{
//
////            try recordingSession.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth])
//            try recordingSession.overrideOutputAudioPort(.speaker)
//            try recordingSession.setActive(true)
//        } catch{
//            print(error.localizedDescription)
//        }
//
//        if let number:Int =  UserDefaults.standard.object(forKey: "myNumber") as? Int{
//
//            numberOfRecords = number
//        }
//
//        AVAudioSession.sharedInstance().requestRecordPermission{(hasPermission) in
//            if hasPermission
//            {
//                print("Accepted")
//            }
//        }
//
//    }
////Function that gets path to directory
//
//        func getDirectory() -> URL
//           {
//
//                   let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//                   let documentDirectory = paths[0]
//                   return documentDirectory
//
//           }
//
////Function That Displays An Alert
//
//            func displayAlert(title:String, message:String){
//                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
////                present(alert, animated: true, completion: nil)
//            }
//
//
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//
//           if editingStyle == .delete{
//               let alertView = UIAlertController(title: "", message: "Are you sure you want to delete the patient ? ", preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
//                        var path = self.getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
////                        var recording = self.[indexPath.row]
//                        audio.remove(at: indexPath.row)
//
//                   })
//                   let cancelAction = UIAlertAction(title: "Cancel", style:.cancel, handler: { (alert) in
//                        print("Cancel")
//                   })
//                   alertView.addAction(okAction)
//                   alertView.addAction(cancelAction)
//                   self.present(alertView, animated: true, completion: nil)
//
//
//
//
//
//
//
//
//           }
//       }
//
//
//
////function play
//
////    func play(){
////        if audioPlayer.isPlaying{
////            audioPlayer.pause()
////        }
////        else{
////            audioPlayer()
////        }
////    }
//
//
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
//
//
//
//
//
//        do {
//
//            player = AVPlayer(url: path)
//                           playerViewController.player = player
//                   //        let activityViewController = UIActivityViewController(activityItems: ["Name To Present to User", getDirectory()], applicationActivities: nil)
//            self.present(playerViewController, animated: true, completion: {
//                self.playerViewController.player?.play()
//
//
//            })
//
////            audioPlayer = try AVAudioPlayer(contentsOf: path)
////            audioPlayer.play()
////            isPlaying = true
////            print(audioPlayer.currentTime)
//
////            if audioPlayer.isPlaying{
////                isPlaying = true
////                print(audioPlayer.currentTime)
////            }
////            else{
////                isPlaying = false
////            }
//
//        }
//        catch{
//
//        }

//
//    }
////}
