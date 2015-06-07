//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Kelly Innes on 6/2/15.
//  Copyright (c) 2015 Kelly Innes. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // set or reset the view when it appears
    override func viewWillAppear(animated: Bool) {
        self.resetView()
        recordingLabel.text = "tap to record"
    }
    
    // DRY
    func resetView() {
        stopButton.hidden = true
        stopLabel.hidden = true
        recordButton.enabled = true
        recordingLabel.hidden = false
    }
    
    // record audio
    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden = false
        stopLabel.hidden = false
        recordButton.enabled = false
        recordingLabel.text = "recording"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // stop recording
    @IBAction func stopRecording(sender: UIButton) {
        self.resetView()
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    // call segue
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if (flag) {
            recordedAudio = RecordedAudio(path: recorder.url, title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
    }
    
    // segue to PlaySoundsViewController
    // and pass it the RecordedAudio object
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
}

