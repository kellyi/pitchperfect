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
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    
    var player = AVAudioPlayer()
    var receivedAudio = RecordedAudio()
    var engine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        player.enableRate = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        NSLog("playing slow audio")
        playSpeed("slow")
    }

    @IBAction func playFast(sender: UIButton) {
        NSLog("playing fast audio")
        playSpeed("fast")
    }
    
    @IBAction func stopPlaying(sender: UIButton) {
        player.stop()
    }
    
    func playSpeed(speed: NSString) {
        var play_rate = speed == "slow" ? 0.5 : 2.0
        player.stop()
        player.rate = Float(play_rate)
        player.currentTime = 0.0
        player.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        var pitchPlayer = AVAudioPlayerNode()
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = 1200.0
        
        engine.attachNode(pitchPlayer)
        engine.attachNode(timePitch)
        
        
        
    }
    
    func playPitch(pitch: NSString) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
