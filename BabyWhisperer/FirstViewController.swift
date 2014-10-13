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
    var timer: NSTimer = NSTimer();
    
    @IBOutlet weak var decibelsLabel: UILabel!
    
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

        super.init(coder: aDecoder)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "test", userInfo: nil, repeats: true)
    }
    
    func test() {
        recorder.updateMeters();
        decibelsLabel.text = NSString(format:"%.2f", recorder.peakPowerForChannel(0));
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
/*        var refreshAlert = UIAlertView()
        refreshAlert.title = "Refresh?"
        refreshAlert.message = "All data will be lost."
        refreshAlert.addButtonWithTitle("Cancel")
        refreshAlert.addButtonWithTitle("OK")
        refreshAlert.show()
*/
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

