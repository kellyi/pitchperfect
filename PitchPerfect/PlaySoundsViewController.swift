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
    var receivedAudio = RecordedAudio()
    var recordingFile:AVAudioFile!
    var engine:AVAudioEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine = AVAudioEngine()
        recordingFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        player.enableRate = true
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playSpeed(0.5)
    }

    @IBAction func playFast(sender: UIButton) {
        playSpeed(2.0)
    }
    
    @IBAction func stopPlaying(sender: UIButton) {
        player.stop()
    }
    
    func playSpeed(speed: Float) {
        player.stop()
        player.rate = Float(speed)
        player.currentTime = 0.0
        player.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playPitch(1000)
    }
    
    @IBAction func playDarf(sender: UIButton) {
        playPitch(-1000)
    }
    
    func playPitch(pitch: Float) {
        player.stop()
        engine.stop()
        engine.reset()
        
        var pitchPlayer = AVAudioPlayerNode()
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        
        engine.attachNode(pitchPlayer)
        engine.attachNode(timePitch)
        engine.connect(pitchPlayer, to: timePitch, format: recordingFile.processingFormat)
        engine.connect(timePitch, to: engine.outputNode, format: recordingFile.processingFormat)
        pitchPlayer.scheduleFile(recordingFile, atTime: nil, completionHandler: nil)
        engine.startAndReturnError(nil)
        
        pitchPlayer.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
