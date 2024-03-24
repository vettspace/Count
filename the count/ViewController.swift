//
//  ViewController.swift
//  the count
//
//  Created by Vitaly Orlov on 24.02.2024.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.orderOut(self)
        
    }

    override var representedObject: Any? {
        didSet {
            
        }
    }
   
    override func viewDidAppear() {
        super.viewDidAppear()
        
        self.view.window?.orderOut(self)
   
    }
  
   
    
   
}

