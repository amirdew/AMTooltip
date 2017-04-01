//
//  ViewController.swift
//  AMTooltip
//
//  Created by amir on 4/1/17.
//  Copyright © 2017 amirdew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        AMTooltipView(side: .bottom, message: "some messages", focusView:targetView, target: self)
        
    }


}

