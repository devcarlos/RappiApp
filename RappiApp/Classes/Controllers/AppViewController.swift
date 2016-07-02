//
//  AppViewController.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {
    
    //MARK : IBOutlets
    
    
    
    //MARK : Properties
    
    //MARK : ViewController Lifetime
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure UI settings
        self.configureUI()        
    }
    
    func configureUI(){
        
    }
    
    deinit {
    }
    
    
    //MARK : Actions
    
    
    
}
