//
//  SecondViewController.swift
//  BabyWhisperer
//
//  Created by Zdenek Sejcek on 13/10/14.
//  Copyright (c) 2014 Zdenek Sejcek. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {

    @IBAction func editingChanged(sender: AnyObject) {

    }
    
    @IBOutlet weak var thresholdLabel: UILabel!
    
    @IBOutlet weak var thresholdSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func valueChanged(sender: AnyObject) {
        self.thresholdLabel.text = NSString(format:"%.2f", self.thresholdSlider.value);
    }

}

