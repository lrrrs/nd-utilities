//
//  ViewController.swift
//  SwiftTests
//
//  Created by Lars Gerckens on 25.03.15.
//
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let e = EventObject()
        e.addTarget(self, action: ViewController.testMethod, controlEvent: 1)
        e.performActionForControlEvent(1)
        e.removeTargetForControlEvent(self, controlEvent: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func testMethod()
    {
        
    }
}

