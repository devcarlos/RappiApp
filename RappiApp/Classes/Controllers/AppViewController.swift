//
//  AppViewController.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit
import AlamofireImage
import StoreKit

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}

class AppViewController: UIViewController, SKStoreProductViewControllerDelegate {
    
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.summaryLabel.scrollEnabled = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func configureUI(){
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad  {
            self.heightConstraint.constant = 600
        } else {
            self.heightConstraint.constant = 200
        }
        
        if let app = app {
            
            self.summaryLabel.scrollEnabled = false
            
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
        
        if Platform.isSimulator {
            
            self.showAlert("Using Simulator", message: "Please Use a Real Device to Test Download", handler: nil)
            
        } else {
            if let app = app {
                let url = NSURL(string: app.linkURL)!
                let idStr = url.lastPathComponent!
                let appID = idStr.substringFromIndex(idStr.startIndex.advancedBy(2))
                NSLog("appID: \(appID)")
                
                openStoreProductWithiTunesItemIdentifier(appID)
            }
        }
        
    }
    
    func openStoreProductWithiTunesItemIdentifier(identifier: String) {
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self
        
        let parameters = [ SKStoreProductParameterITunesItemIdentifier : identifier]
        storeViewController.loadProductWithParameters(parameters) { [weak self] (loaded, error) -> Void in
            if loaded {
                // Parent class of self is UIViewContorller
                self?.presentViewController(storeViewController, animated: true, completion: nil)
            }
        }
    }
    func productViewControllerDidFinish(viewController: SKStoreProductViewController) {
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func doneAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}

