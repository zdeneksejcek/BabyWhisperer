//
//  FirstViewController.swift
//  BabyWhisperer
//
//  Created by Zdenek Sejcek on 13/10/14.
//  Copyright (c) 2014 Zdenek Sejcek. All rights reserved.
//

import UIKit
import AVFoundation;

class FirstViewController: UIViewController {
    var recorder : AVAudioRecorder;
    var audioPlayer : AVAudioPlayer;
    var timer: NSTimer = NSTimer();
    
    @IBOutlet weak var playStopButton: UIButton!
    @IBOutlet weak var decibelsLabel: UILabel!
    
    @IBAction func buttonTouchedDown(sender: UIButton) {
        if (audioPlayer.playing) {
            audioPlayer.stop()
            sender.setTitle("Start playing", forState: UIControlState.Normal)
//            playStopButton.setTitle("Start playing", forState: UIControlState.Normal)
        } else {
            audioPlayer.currentTime = 0;
            audioPlayer.prepareToPlay();
            audioPlayer.play()

            sender.setTitle("Stop playing", forState: UIControlState.Normal)
//            playStopButton.setTitle("Stop playing", forState: UIControlState.Normal)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        var recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Low.toRaw(),
            AVNumberOfChannelsKey: 1,
            AVSampleRateKey : 44100.0
        ]
        
        var url: NSURL = NSURL.URLWithString(NSTemporaryDirectory().stringByAppendingPathComponent("tmp.caf"))
        
        self.recorder = AVAudioRecorder(URL:url, settings:recordSettings, error:nil)
        self.recorder.meteringEnabled = true;

        self.recorder.record()

        var mp3Path = NSBundle.mainBundle().pathForResource("lullaby", ofType: "mp3")
        var mp3Url = NSURL.URLWithString(mp3Path!);
        
        audioPlayer = AVAudioPlayer(contentsOfURL: mp3Url, error: nil)
        
        super.init(coder: aDecoder)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateMeters", userInfo: nil, repeats: true)
    }
    
    func updateMeters() {
        recorder.updateMeters();
        decibelsLabel.text = NSString(format:"%.2f", recorder.peakPowerForChannel(0));
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

