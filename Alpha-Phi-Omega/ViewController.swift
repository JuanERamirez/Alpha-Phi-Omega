//
//  ViewController.swift
//  Alpha-Phi-Omega
//
//  Created by Local Account 436-24 on 2/26/18.
//  Copyright © 2018 Juan Ramirez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Button(_ sender: UIButton) {
        if button.isSelected {
           label.text = "Hi Sindia!!"
        }
    }

}

