
//  recordViewController.swift
//  core
//The view controller is for recording
//  Created by Apple on 26/04/2021.
//  Copyright © 2021 Haider Tamsil. All rights reserved.


import UIKit
import SwiftUI
import CoreData
import AVFoundation
import AVKit
import CoreBluetooth
import SoundWave

let keyID = "key"
let idString = String("00001101-0000-1000-8000-00805F9B34FB")


let UstehCBUUID = CBUUID(string: idString )


struct Recording {
    var name: String
    var path: URL
}



class recordViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate, CBCentralManagerDelegate,  CBPeripheralDelegate {
   
    
        enum AudioRecodingState {
            case ready
            case recording
            case recorded
            case playing
            case paused

            var audioVisualizationMode: AudioVisualizationView.AudioVisualizationMode {
                switch self {
                case .ready, .recording:
                    return .write
                case .paused, .playing, .recorded:
                    return .read
                }
            }
        }

    
    
    
    var manager:CBCentralManager!
    var peripheral: CBPeripheral!
    var GlobalMessage = ""

    @IBOutlet var heartBackView: UIView!
    
    @IBOutlet var LungsBackView: UIView!
    
    @IBOutlet var BpBackView: UIView!
    
    
    //For bluetooth setup
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {



        switch central.state {
        case .poweredOn:
            GlobalMessage = "Bluetooth is on"
            manager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])

        case .poweredOff:
            GlobalMessage = "Bluetooth is off "

        case .unknown:
            GlobalMessage = "unkwnown"
        case .resetting:
            GlobalMessage = "Resetting"
        case .unsupported:
            GlobalMessage = "Unsupported"
        case .unauthorized:
            GlobalMessage = "Unauthorized"
        }

        print("hi", GlobalMessage)
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("these are peripherals")
        print(peripheral)
        print(peripheral.name)

    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {

if peripheral == self.peripheral {
    print("Connected to your Particle Board")
    peripheral.discoverServices([ParticlePeripheral.particleLEDServiceUUID])
}
    }


    
    
       var recordings: [Recording] = []
       var player = AVPlayer()
       var playerViewController = AVPlayerViewController()
       var recordingSession: AVAudioSession!
       var audioRecorder: AVAudioRecorder!
       var numberOfRecords = 0
       var audioPlayer: AVAudioPlayer?
       let engine = AVAudioEngine()
       var isPlaying = false
       var FilePath = ""
       var Patient = " "
       

    var position:String!=nil
    var location:String!=nil
    
    @IBOutlet weak var gifImage: UIImageView!
    
    
    @IBOutlet var HeartBtnOutlet: UIButton!
    
    @IBOutlet var LungsButtonOutlet: UIButton!
    
    @IBOutlet var BPButtonOutlet: UIButton!
    
    @IBOutlet weak var heart_Outlet: UILabel!
    @IBOutlet weak var lungs_Outlet: UILabel!
    @IBOutlet weak var BP_Outlet: UILabel!
    
    var mode = "heart"
    
    @IBAction func heart(_ sender: Any) {
        mode = "heart"
        heartBackView.isHidden = false
        LungsBackView.isHidden = true
        BpBackView.isHidden = true
        
        
        locationOutlet.setTitle("Location", for: [])
        
    }
    
    
    @IBAction func lungs(_ sender: Any) {
        mode = "lungs"
        
        heartBackView.isHidden = true
        LungsBackView.isHidden = false
        BpBackView.isHidden = true
        
        locationOutlet.setTitle("Location", for: [])
    }
    
    
    @IBAction func BP(_ sender: Any) {
        mode = "BP"
        
        heartBackView.isHidden = true
        LungsBackView.isHidden = true
        BpBackView.isHidden = false
        
        
        
        locationOutlet.setTitle("Location", for: [])
    }
    
    
    
    
    
    
    
    @IBOutlet weak var positionOutlet: UIButton!

    @IBOutlet weak var locationOutlet: UIButton!
    
    
    
    @IBOutlet weak var shareLabel: UIButton!
    
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var btnLabel: UIButton!

//    var Position = PositionViewController()

    @IBOutlet private var audioVisualizationView: AudioVisualizationView!
     private var chronometer: Chronometer?
  
//    @IBOutlet var AudioTable: UITableView!
    
private let viewModel = ViewModel()
    var student: Student?
     private var currentState: AudioRecodingState = .ready {
            didSet {
    //            self.recordButton.setImage(self.currentState.buttonImage, for: .normal)
                self.audioVisualizationView.audioVisualizationMode = self.currentState.audioVisualizationMode
    //            self.clearButton.isHidden = self.currentState == .ready || self.currentState == .playing || self.currentState == .recording
            }
        }
    
    func loadRecordings() {
        let filemanager = FileManager.default
        let documentsDirectory = filemanager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let paths = try filemanager.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [])
            for path in paths {
                let recording = Recording(name: path.lastPathComponent, path: path)
                self.recordings.append(recording)
            }
            
        } catch {
            print(error)
        }
    }

    
    func createAudioRecordPath() -> URL {
        let format = DateFormatter()
        format.dateFormat="yyyy-MM-dd"
        
        self.FilePath = "recording-\(format.string(from: Date()))" + ".wav"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(self.FilePath)
        let recording = Recording(name: FilePath, path: url)
        self.recordings.append(recording)
        return url
    }
    
    
    @IBOutlet weak var saveLabel: UIButton!

    
    @IBAction func record(_ sender: Any) {
        
     
    
         
        
        if GlobalMessage != "Bluetooth is on"{
            let alertView = UIAlertController(title: "Alert", message: "Please turn-On your bluetooth and connect NoaScope Device" , preferredStyle: .alert)
                       let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                        
                        var url = NSURL(string: "prefs:root=Bluetooth")
                        UIApplication.shared.openURL(url! as URL)

                                      })
                       alertView.addAction(okAction)
            alertView.view.tintColor = UIColor.black
                       self.present(alertView, animated: true, completion: nil)


            return
        }
        
        
        
         
        
       
        if location == "" || position == "" {
            
            let alertView = UIAlertController(title: "Alert", message: "Select Location & Position" , preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                           })
            alertView.addAction(okAction)
            alertView.view.tintColor = UIColor.black
            self.present(alertView, animated: true, completion: nil)
            
            
            return
        }
        
        else {
            
        
            
        
            
        print("this is",Patient)
        
            
            
            
        
        buttonLabel.isHidden = true
        playLabel.isHidden = true
        saveLabel.isHidden = true
        shareLabel.isHidden = true
        print(location)
        print(position)


        if audioRecorder == nil{


            let settings = [AVFormatIDKey: kAudioFormatLinearPCM, AVLinearPCMBitDepthKey: 16, AVLinearPCMIsFloatKey: true, AVNumberOfChannelsKey: 1, AVSampleRateKey: 8000] as [String : Any]
            
            
            


                   //Start Audio Recording
                   do{
                    
                    let filename = createAudioRecordPath()
                    audioRecorder = try AVAudioRecorder(url: filename, settings: settings)
                    
                    let audioSession = AVAudioSession.sharedInstance()
                            do {

                                try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .allowBluetooth)
                                   try audioSession.setMode(AVAudioSessionModeDefault)
                                   try audioSession.setActive(true)
                                if let availableInputs = AVAudioSession.sharedInstance().availableInputs {
                                    print("Found \(availableInputs.count) inputs")
                                    for input in availableInputs {
                                        print("Input: \(input)")
                                        if input.portType == AVAudioSessionPortBluetoothHFP {
                                            print("Setting preferred input")
                                            do {
                                                try AVAudioSession.sharedInstance().setPreferredInput(input)
                                            } catch {
                                                print("Error setting preferred input: \(error)")
                                            }
                                        }
                                    }
                                }
                                   
                               } catch {
                                   print(error)
                               }
                    
                    try self.viewModel.resetRecording()
                    self.audioVisualizationView.reset()
                    self.currentState = .ready
                    if self.currentState == .ready {
                        
                        
                        self.viewModel.startRecording { [weak self] soundRecord, error in
                            if let error = error {
                                self?.showAlert(with: error)
                                return
                            }

                            self?.currentState = .recording

                            self?.chronometer = Chronometer()
                            self?.chronometer?.start()
                        }
                    }
                    
                    audioRecorder.delegate = self
                    audioRecorder.record()
                    print("This is audioooo", audioRecorder.format)

                    buttonLabel.setTitle("Stop", for: .normal)

                   }
                   catch{
                       displayAlert(title: "Oops!", message: "Recording Failed")
                   }
            
            
            stopLabel.isHidden = false
            
            
            
               }
                
        }

    }
    
    

    
    @IBOutlet weak var playLabel: UIButton!
    

    
    @IBAction func Save(_ sender: Any) {
        
        let DocumentDirectory =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let DirPath = DocumentDirectory.appendingPathComponent("NEW_REC")
        do
               {
                   try FileManager.default.createDirectory(atPath: DirPath.path, withIntermediateDirectories: true, attributes: nil)
               }
               catch let error as NSError
               {
                   print("Unable to create directory \(error.debugDescription)")
               }
               print("Dir Path = \(DirPath)")
               
               
               
               
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
               
        let newFile = "recording-\(format.string(from: Date()))" + ".wav"
           
            
        print("This is start", DirPath)
        let file = DirPath.appendingPathComponent(newFile)
        print("end-----", file)
        let url = DocumentDirectory.appendingPathComponent(FilePath)
        let recording = Recording(name: FilePath, path: url)
        self.recordings.append(recording)
                
           
        do {
                
               
                
                if FileManager.default.fileExists(atPath: file.path) {
    try FileManager.default.removeItem(at: file)
}
                
    try FileManager.default.copyItem(at: recording.path, to: file)
                  } catch (let error) {
    print("Cannot copy item at \(recording.path) to \(DirPath): \(error)")
                      
    }
                
    let VC = self.storyboard?.instantiateViewController(withIdentifier: "diagnosisViewController") as! diagnosisViewController
    
    

       
        
        
        
    VC.Patient = self.Patient
    VC.location = self.location
    VC.position = self.position
    VC.filePath = newFile
        
        var fileLocation = recording.path
        guard let data = try? Data(contentsOf:fileLocation) else { return }
        let base64String = data.base64EncodedData(options: .lineLength76Characters)
        
        
        let str = String(decoding: base64String, as: UTF8.self)
    
    VC.base64 = str.self
        
        
    self.present(VC, animated: true, completion: nil)
        
    print("this is diagnosis", VC.location)
    print("this is position", VC.position)
    print("this is base64", VC.base64)
        
    }
    
    
    
    @IBAction func play(_ sender: Any) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(self.FilePath)
        let recording = Recording(name: FilePath, path: url)
        self.recordings.append(recording)




    do {
                        
//        let filee = try String(contentsOf: recording.path)
        
//        let url = Bundle.main.url(forResource: FilePath , withExtension: "wav")
        let file = try AVAudioFile(forReading: recording.path)
        let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: file.fileFormat.sampleRate, channels: 1, interleaved: false)

        var audioLengthSamples = file.length
//        print("this is audio length Samples", audioLengthSamples)
//        var DoubleArray = Double(audioLengthSamples)
//        print("This is our samples",DoubleArray)
        var sampleRate = format?.sampleRate
//        print("SampleRate:", sampleRate)
        
        
        
        let buf = AVAudioPCMBuffer(pcmFormat: format!, frameCapacity: AVAudioFrameCount(audioLengthSamples))
        try! file.read(into: buf!)

        // this makes a copy, you might not want that
        let floatArray = Array(UnsafeBufferPointer(start: buf?.floatChannelData![0], count:Int(buf!.frameLength)))

//        print("floatArray \(floatArray)\n")
        


        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

//        let newFiltered = try createWavFile(using: NewData)
//        let newFile = try storeMusicFile(data: NewData)

//        let recording = Recording(name: newFile, path: storeMusicFile(data: ))
//               self.recordings.append(recording)

        

                
            self.player = AVPlayer(url: recording.path)
                           
            self.playerViewController.player = self.player
                                  
            self.present(self.playerViewController, animated: true, completion: {
            
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
        
        
        DispatchQueue.global(qos: .background).async {

    
             let floatArray = Array(UnsafeBufferPointer(start: buf?.floatChannelData![0], count:Int(buf!.frameLength)))
               let DoubleArray : [Double] = floatArray.map { Double($0) }
               let FilteredAudio : [Double] = Filterr.shareInstance.Filter(DoubleArray)
               let FilteredArray : [Float] = FilteredAudio.map { Float($0)}
               //        print("My Filtered Array", FilteredArray)

               self.saveWav(FilteredArray)
           }

                       }
                       catch{
                            print("Error")
                       }
        
        
       

    }
    

    
    @IBAction func share(_ sender: Any) {
      let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
      let url = documentsDirectory.appendingPathComponent("filtered.wav")
        let recording = Recording(name: url.path, path: url)
      self.recordings.append(recording)
        
       
        
        let activityController = UIActivityViewController(activityItems: [recording.path], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {(nil,completed,_,error)
            in
            if completed {
                print("completed")
                
            }else {
                print("Canceled")
            }
        }
            
            present(activityController,animated: true){
            print("presented")
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    @IBOutlet var stopLabel: UIButton!
    
    @IBAction func stopRecording(_ sender: Any) {
        
        
        switch self.currentState {
        case .recording:
            self.chronometer?.stop()
            self.chronometer = nil

            self.viewModel.currentAudioRecord!.meteringLevels = self.audioVisualizationView.scaleSoundDataToFitScreen()
            self.audioVisualizationView.audioVisualizationMode = .read

            do {
                try self.viewModel.stopRecording()
                self.currentState = .recorded
            } catch {
                self.currentState = .ready
                self.showAlert(with: error)
            }
//        case .recorded, .paused:
//            do {
//                let duration = try self.viewModel.startPlaying()
//                self.currentState = .playing
//                self.audioVisualizationView.meteringLevels = self.viewModel.currentAudioRecord!.meteringLevels
//                self.audioVisualizationView.play(for: duration)
//            } catch {
//                self.showAlert(with: error)
//            }
        case .playing:
            do {
                try self.viewModel.pausePlaying()
                self.currentState = .paused
                self.audioVisualizationView.pause()
            } catch {
                self.showAlert(with: error)
            }
        default:
            break
        }
        
//        gifImage.isHidden = true
        buttonLabel.isHidden = false
        stopLabel.isHidden = true
        playLabel.isHidden = false
        saveLabel.isHidden = false
        shareLabel.isHidden = false
        
                    //stopRecording
                    print("Recording is now stopped 1234")
                    audioRecorder.stop()
                    audioRecorder = nil
//                    AudioTable.reloadData()
        //            self.loadView()
                    print("Recording is now stopped")
                    buttonLabel.setTitle("Record", for: .normal)
                    

  

                

    }
    
    

//    func getDirectory() -> URL
//              {
//
//                      let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//                      let documentDirectory = paths[0]
//                      return documentDirectory
//
//              }



    func displayAlert(title:String, message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
    //                present(alert, animated: true, completion: nil)
        }


//    @IBSegueAction func uiview(_ coder: NSCoder) -> UIViewController? {
//        return UIHostingController(coder: coder, rootView: ContentView())
//    }


    @IBAction func location(_ sender: Any) {
        
     
        if mode == "lungs"{
             let VC = self.storyboard?.instantiateViewController(withIdentifier: "LungsViewController") as! LungsViewController
             self.present(VC, animated: true, completion: nil)
            
        }
        if mode == "heart"{
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
           self.present(VC, animated: true, completion: nil)
        }
        if mode == "BP"{
           let VC = self.storyboard?.instantiateViewController(withIdentifier: "BPViewController") as! BPViewController
           self.present(VC, animated: true, completion: nil)
        }
        
    }
    
    @objc func didGetNotification(_ notification: Notification){
        let text = notification.object as! String?
        location = text
        locationOutlet.setTitle(location, for: [])
    }
    
    @objc func didGetNotification2(_ notification: Notification){
           let text2 = notification.object as! String?
           position = text2
         positionOutlet.setTitle(position, for: [])
       }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        positionOutlet.setTitle(position, for: [])
//        locationOutlet.setTitle(location, for: [])
//
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(getDirectory())
        print("im id string", idString)
        
        
        
        
        heartBackView.layer.cornerRadius = 12.5
        LungsBackView.layer.cornerRadius = 12.5
        BpBackView.layer.cornerRadius = 12.5
        
        
        
       manager = CBCentralManager(delegate: self, queue: nil)
//       centralManagerDidUpdateState(manager)
         self.viewModel.askAudioRecordingPermission()

                self.viewModel.audioMeteringLevelUpdate = { [weak self] meteringLevel in
                    guard let self = self, self.audioVisualizationView.audioVisualizationMode == .write else {
                        return
                    }
                    self.audioVisualizationView.add(meteringLevel: meteringLevel)
                }

                self.viewModel.audioDidFinish = { [weak self] in
                    self?.currentState = .recorded
                    self?.audioVisualizationView.stop()
                }
        
    
      AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: 8000, channels: 1, interleaved: true)
        
      let audioSession = AVAudioSession.sharedInstance()
          do {

                try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .allowBluetooth)
                try audioSession.setMode(AVAudioSessionModeDefault)
                try audioSession.setActive(true)
            } catch {
                print(error)
            }
        
        
        location = ""
        position = ""
        
//        gifImage.isHidden = true
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification(_:)), name: Notification.Name("text"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotification2(_:)), name: Notification.Name("text2"), object: nil)
        
        
        print("This is Documents",createAudioRecordPath())
//        AudioTable.delegate = self
//        AudioTable.dataSource = self
//
        print(createAudioRecordPath() as Any)
        print(loadRecordings())
        recordingSession = AVAudioSession.sharedInstance()
               do{

//                   try recordingSession.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth])
                   try recordingSession.overrideOutputAudioPort(.speaker)
                   try recordingSession.setActive(true)
               } catch{
                   print(error.localizedDescription)
               }

//               if let number:Int =  UserDefaults.standard.object(forKey: "myNumber") as? Int{
//
//                   numberOfRecords = number
//               }
//        AudioTable.reloadData()
               AVAudioSession.sharedInstance().requestRecordPermission{(hasPermission) in
                   if hasPermission
                   {
                       print("Accepted")
                   }
               }

//        AudioTable.register(UITableViewCell.self , forCellReuseIdentifier: "cellid")


        // Do any additional setup after loading the view.
    }
        
    
    
    
    func saveWav(_ buf: [Float]) {
        if let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: 8000, channels: 1, interleaved: false) {
            let pcmBuf = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(buf.count))
            memcpy(pcmBuf?.floatChannelData?[0], buf, 4 * buf.count)
           
            pcmBuf?.frameLength = UInt32(buf.count)

            let fileManager = FileManager.default
            do {
                let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
                try FileManager.default.createDirectory(atPath: documentDirectory.path, withIntermediateDirectories: true, attributes: nil)
                let fileURL = documentDirectory.appendingPathComponent("filtered.wav")
                let recording = Recording(name: fileURL.path, path: fileURL)
                
                let audioFile = try AVAudioFile(forWriting: fileURL, settings: format.settings)
                try audioFile.write(from: pcmBuf!)
            } catch {
                print(error)
            }
        }
    }
    
    
    
    
    
    @IBAction func saveRaw(_ sender: Any) {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let url = documentsDirectory.appendingPathComponent(self.FilePath)
        let recording = Recording(name: FilePath, path: url)
        self.recordings.append(recording)

               
              
               
        let activityController = UIActivityViewController(activityItems: [recording.path], applicationActivities: nil)
               
        activityController.completionWithItemsHandler = {(nil,completed,_,error)
                   in
                   if completed {
                       print("completed")
                       
                   }else {
                       print("Canceled")
                   }
               }
                   
                   present(activityController,animated: true){
                   print("presented")
                   
               }
        


}
    
    
    
}





extension FileManager {

    open func secureCopyItem(at srcURL: URL, to dstURL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: dstURL.path) {
                try FileManager.default.removeItem(at: dstURL)
            }
            try FileManager.default.copyItem(at: srcURL, to: dstURL)
        } catch (let error) {
            print("Cannot copy item at \(srcURL) to \(dstURL): \(error)")
            return false
        }
        return true
    }

}





extension UIColor {
    static var customGrey: UIColor {
        return UIColor(red: 235, green: 235, blue: 235, alpha: 1.0)
    }

    // Add more custom colors as needed
}
