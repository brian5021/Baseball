//
//  SecondViewController.swift
//  Baseball
//
//  Created by Brian Cox on 8/15/15.
//  Copyright © 2015 Brian Cox. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func PostTest(sender: UIButton) {
        performPost()
    }
    
    func performPost(){
        RestApiManager.sharedInstance.postState { json -> Void in
            return json["results"]
        }
    }

}

