//
//  ViewController.swift
//  AMTooltip_Example
//
//  Created by amir on 4/2/17.
//  Copyright © 2017 amirdew. All rights reserved.
//

import UIKit
import AMTooltip

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showTooltipAction(_ sender: Any) {
        
        
        AMTooltipView(message: "some text",
                      focusView: sender as! UIView,
                      target: self)
        
    }
    
    
    @IBAction func showCustomizedTooltipAction(_ sender: Any) {
        
        

        
        AMTooltipView(
            options:AMTooltipViewOptions(
                textColor: UIColor.white,
                textBoxBackgroundColor: UIColor.gray,
                addOverlayView: false,
                lineColor: UIColor.gray,
                dotColor: UIColor.lightGray,
                dotBorderColor: UIColor.gray
            ),
            message: "some customized text",
            focusView: sender as! UIView,
            target: self)
        
    }
    

}

