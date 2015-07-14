//
//  LearnMoreViewController.swift
//  Tips
//
//  Created by Aaron Brown on 7/14/15.
//  Copyright (c) 2015 BrownDogLabs. All rights reserved.
//

import UIKit

class LearnMoreViewController: UIViewController {
    @IBOutlet weak var factDetails: UILabel!
    
    var factDetailsText = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        factDetails.text = factDetailsText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
