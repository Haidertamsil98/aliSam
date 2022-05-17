//
//  ViewController.swift
//  Recorder
//
//  Created by Apple on 28/12/2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import SwiftUI
import Combine
let keyID = "key"

class RecorderViewController: UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource ,  ObservableObject {
    
    
    //Setting Up our table vieww
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRecords
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
        
    }
    
    //visualiser function
    
    
//    fileprivate func setupAudioView() {
//        var defaultFrame: CGRect = CGRect(x: 0, y: 24, width: recorderView.frame.width, height: 135)
//        defaultFrame = self.recorderView.frame
//
//
//        audioView.frame = CGRect(x: 0, y: 24, width: recorderView.frame.width, height: 135)
//        recorderView.addSubview(audioView)
//        //TODO: Add autolayout constraints
//
//
//        audioView.alpha = 1
//        audioView.isHidden = false
//
////        visualiser.gradientStartColor = .white
//
//    }
//
    

   
//    var recordButton: UIButton!
//    var audioView = visualiser()
    var node = AVAudioPlayerNode()
    var player = AVPlayer()
    var playerViewController = AVPlayerViewController()
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var numberOfRecords = 0
    var audioPlayer: AVAudioPlayer!
    let engine = AVAudioEngine()
    var isPlaying = false
    
    
    @IBOutlet weak var recorderView: UIView!
    
    
    
//    @IBOutlet weak var recorderView: UIView!
    
    
    @IBOutlet weak var buttonLabel: UIButton!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func record(_ sender: Any) {
        
//        let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        
        
        
        
        //Check if we have an active recorder
        if audioRecorder == nil{
             numberOfRecords += 1
            
            //Timer to find current time of audio
            let filename = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
            
            let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            //Start Audio Recording
            do{
                audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                print(getDirectory() as URL)
//                do{
//                    try! engine.start()
//                } catch {
//                    print(error)
//                }

            
                buttonLabel.setTitle("Stop Recording", for: .normal)
                
                
            }
            catch{
                displayAlert(title: "Oops!", message: "Recording Failed")
            }
        }
       
        else{
            //stopRecording
            audioRecorder.stop()
//            try! engine.stop()
            
            audioRecorder = nil
            
            UserDefaults.standard.set(numberOfRecords, forKey: "myNumber")
            myTableView.reloadData()
            
            buttonLabel.setTitle("Start Recording", for: .normal)
            
        }
                
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupAudioView()
        

        
        let input = engine.inputNode

        engine.attach(node)
        
        let bus = 0
        let inputFormat = input.inputFormat(forBus: bus)
        
        engine.connect(node, to: engine.mainMixerNode, format: inputFormat)
        
        input.installTap(onBus: bus, bufferSize: 512, format: inputFormat) { (buffer, time) -> Void in
            self.node.scheduleBuffer(buffer)
            print(buffer)
        }

        
        
        
        
        
        
        // Do any additional setup after loading the view.
        recordingSession = AVAudioSession.sharedInstance()
        do{
            
//            try recordingSession.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth])
            try recordingSession.overrideOutputAudioPort(.speaker)
            try recordingSession.setActive(true)
        } catch{
            print(error.localizedDescription)
        }
        
        if let number:Int =  UserDefaults.standard.object(forKey: "myNumber") as? Int{
            
            numberOfRecords = number
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission{(hasPermission) in
            if hasPermission
            {
                print("Accepted")
            }
        }
        
    }
//Function that gets path to directory
            
        func getDirectory() -> URL
           {
                           
                   let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                   let documentDirectory = paths[0]
                   return documentDirectory
                           
           }
         
//Function That Displays An Alert
            
            func displayAlert(title:String, message:String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
//                present(alert, animated: true, completion: nil)
            }
            
    
//function play
//
//    func play(){
//        if audioPlayer.isPlaying{
//            audioPlayer.pause()
//        }
//        else{
//            audioPlayer()
//        }
//    }
//
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       var path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                if editingStyle == .delete {
            
            tableView.beginUpdates()
            path.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let path = getDirectory().appendingPathComponent("\(indexPath.row).m4a")
       
                
        
        
        
        do {
            
            
            player = AVPlayer(url: path)
                           playerViewController.player = player
                   //        let activityViewController = UIActivityViewController(activityItems: ["Name To Present to User", getDirectory()], applicationActivities: nil)
            self.present(playerViewController, animated: true, completion: {
                self.playerViewController.player?.play()
                
                
            })
            
//            audioPlayer = try AVAudioPlayer(contentsOf: path)
//            audioPlayer.play()
//            isPlaying = true
//            print(audioPlayer.currentTime)
//
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
    
    
    
    
    
//    @IBSegueAction func swiftUIAction(_ coder: NSCoder) -> UIViewController? {
//        return UIHostingController(coder: coder, rootView: ContentView())
//    }
    
}
            
            
            
            
            
        

//        do {
//            try recordingSession.setCategory(.playAndRecord, mode: .default)
//            try recordingSession.setActive(true)
//            recordingSession.requestRecordPermission() { [unowned self] allowed in
//                DispatchQueue.main.async {
//                    if allowed {
//                        self.loadRecordingUI()
//                    } else {
//                        // failed to record!
//                    }
//                }
//            }
//        } catch {
//            // failed to record!
//        }
 

//    func loadRecordingUI() {
//        recordButton = UIButton(frame: CGRect(x: 64, y: 64, width: 500, height: 64))
//        recordButton.setTitle("Tap to Record", for: .normal)
//        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
//        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
//        view.addSubview(recordButton)
//    }
//
//    func startRecording() {
//        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
//
//        let settings = [
//            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//            AVSampleRateKey: 12000,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
//
//        do {
//            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
//            audioRecorder.delegate = self
//            audioRecorder.record()
//
//            recordButton.setTitle("Tap to Stop", for: .normal)
//        } catch {
//            finishRecording(success: false)
//        }
//    }
//
//
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//
//
//    func finishRecording(success: Bool) {
//        audioRecorder.stop()
//        audioRecorder = nil
//
//        if success {
//            recordButton.setTitle("Tap to Re-record", for: .normal)
//        } else {
//            recordButton.setTitle("Tap to Record", for: .normal)
//            // recording failed :(
//        }
//    }
//
//    @objc func recordTapped() {
//        if audioRecorder == nil {
//            startRecording()
//        } else {
//            finishRecording(success: true)
//        }
//    }
//
//
//
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if !flag {
//            finishRecording(success: false)
//        }
//    }
//
//
//
//
//
//
//}
//


//
//struct circle : some View {
//
//   RoundedRectangle(cornerRadius: 0)
//    .fill(LinearGradient(gradient: Gradient(colors: [.red, .pink]),
//                         startPoint: .top,
//                         endPoint: .bottom))
//    // 3
//    .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 3) / CGFloat(numberOfSamples), height: value)
//}
