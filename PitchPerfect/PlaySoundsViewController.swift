//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Kelly Innes on 6/3/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var player:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var recordingFile:AVAudioFile!
    var engine:AVAudioEngine!
    
    // setup objects and view on load
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Play"
        engine = AVAudioEngine()
        recordingFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        player.enableRate = true
    }
    
    // call the playSpeed function with a slow rate
    @IBAction func playSlow(sender: UIButton) {
        playSpeed(0.5)
    }

    // call the playSpeed function with a fast rate
    @IBAction func playFast(sender: UIButton) {
        playSpeed(2.0)
    }
    
    // use the stop button's input to stop the AVAudioPlayer object
    // and to stop and reset the AVAudioEngine object
    @IBAction func stopPlaying(sender: UIButton) {
        self.stopAndReset()
    }
    
    // call the playPitch function with a very high pitch
    @IBAction func playChipmunk(sender: UIButton) {
        playPitch(1000)
    }
    
    // call the playPitch function with a very low pitch
    @IBAction func playDarf(sender: UIButton) {
        playPitch(-1000)
    }
    
    // play file at given rate
    func playSpeed(speed: Float) {
        self.stopAndReset()
        player.rate = speed
        player.currentTime = 0.0
        player.play()
    }
    
    // use AVAudioEngineObject to play file at requested pitch
    func playPitch(pitch: Float) {
        self.stopAndReset()
        var pitchPlayNode = AVAudioPlayerNode()
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        
        engine.attachNode(pitchPlayNode)
        engine.attachNode(timePitch)
        engine.connect(pitchPlayNode, to: timePitch, format: recordingFile.processingFormat)
        engine.connect(timePitch, to: engine.outputNode, format: recordingFile.processingFormat)
        pitchPlayNode.scheduleFile(recordingFile, atTime: nil, completionHandler: nil)
        engine.startAndReturnError(nil)
        
        pitchPlayNode.play()
    }
    
    // DRY
    func stopAndReset() {
        player.stop()
        engine.stop()
        engine.reset()
    }
}
