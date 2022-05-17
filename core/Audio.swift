//
//  Audio.swift
//  core
//
//  Created by Apple on 10/10/2021.
//  Copyright © 2021 HaiderTamsil. All rights reserved.
//
//
//
//import CoreAudio
//import CoreAudioKit
//import OpenAL




//
//
//
//class EZAudioPlot: UIView {
//
//    var mic: AKMicrophone!
//    var tracker: AKFrequencyTracker!
//    var silence: AKBooster!
//
//    @IBOutlet weak var audioInputPlot: EZAudioPlot!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        AKSettings.audioInputEnabled = true
//        mic = AKMicrophone()
//        tracker = AKFrequencyTracker(mic)
//        silence = AKBooster(tracker, gain: 0)
//        setupPlot()
//    }
//
//    func setupPlot() {
//        let plot = AKNodeOutputPlot(mic, frame: audioInputPlot.bounds)
//        plot.plotType = .rolling
//        plot.shouldFill = true
//        plot.shouldMirror = true
//        plot.color = UIColor.blue
//        audioInputPlot.addSubview(plot)
//    }
//
//}
