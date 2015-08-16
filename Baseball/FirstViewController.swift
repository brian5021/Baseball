//
//  FirstViewController.swift
//  Baseball
//
//  Created by Brian Cox on 8/15/15.
//  Copyright © 2015 Brian Cox. All rights reserved.
//

import UIKit
import Foundation


class FirstViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TestButton(sender: UIButton) {
        performGet()
    }
    
    func performGet(){
        RestApiManager.sharedInstance.getState { json -> Void in
            return json["results"]
        }
    }
    
}

