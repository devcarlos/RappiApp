//
//  AppViewController.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit
import AlamofireImage

class AppViewController: UIViewController {
    
    //MARK : IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var copyLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    //MARK : Properties
    
    var app: App? = nil
    
    //MARK : Lifetime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure UI settings
        self.configureUI()        
    }
    
    func configureUI(){
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad  {
            self.heightConstraint.constant = 600
        } else {
            self.heightConstraint.constant = 200
        }
        
        if let app = app {
            
            self.nameLabel.text = app.name
            self.summaryLabel.text = app.summary
            self.summaryLabel.layer.cornerRadius = 5
            
            let placeholderImage = UIImage(named: "placeholder")!
            self.imageView.image = placeholderImage
            
            //download image URL async if internet is available
            if InternetHandler.shared.isReachable() {
                let URL = NSURL(string: app.imageURL)!

                let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                    size: imageView.frame.size,
                    radius: 10.0
                )
                
                self.imageView.af_setImageWithURL(
                    URL,
                    placeholderImage: placeholderImage,
                    filter: filter
                )
            }
            
            
            //category
            self.categoryLabel.text = app.category
            
            //custom Price or Free
            if app.price > 0 {
                self.priceLabel.text = String(format: "$%.2f", app.price)
            } else {
                self.priceLabel.text = "Free"
            }
            
            //copyright text
            self.copyLabel.text = "Copyright \(app.copyright)"
            
        }
    }
    
    
    //MARK : Actions
    
    
    @IBAction func downloadAction(sender: AnyObject) {
        
        if let app = app {
            NSLog("URL: \(app.linkURL)")
            UIApplication.sharedApplication().openURL(NSURL(string: app.linkURL)!)
        }
        
    }
    
}
