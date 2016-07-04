//
//  ListViewController.swift
//  RappiApp
//
//  Created by Carlos Alcala on 6/10/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit

extension ListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 180, height: 180)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
}

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerTransitioningDelegate  {
    
    //MARK : IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK : Properties
    
    let customPresentAnimationController = CustomPresentAnimationController()
    let customDismissAnimationController = CustomDismissAnimationController()
    let customInteractionController = CustomInteractionController()
    
    
    var apps:[App] = []
    var category:String = ""
    
    //MARK : ViewController Lifetime
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    //MARK : Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //configurations
        self.configureUI()
        self.configureTable()
        
        //load API data
        self.loadData()
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.automaticallyAdjustsScrollViewInsets = false
//        
//    }
    
    override func viewDidLayoutSubviews() {

        //FIX the scroll insets on DISMISS back
        NSLog("ORIGIN: \(self.view.frame.origin.y)")
        
        if self.view.frame.origin.y == 0 {
            if let rect = self.navigationController?.navigationBar.frame {
                let y = rect.size.height + rect.origin.y
                self.tableView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0)
                self.collectionView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0)
            }
        } else if self.view.frame.origin.y == 44 || self.view.frame.origin.y == 64 {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureUI() {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad  {
            self.collectionView.backgroundColor = UIColor.clearColor()
            self.tableView.hidden = true
            self.collectionView.hidden = false
            
            self.edgesForExtendedLayout = UIRectEdge.None
            
        } else {
            self.tableView.backgroundColor = UIColor.clearColor()
            self.tableView.hidden = false
            self.collectionView.hidden = true
        }
    }
    
    func configureTable() {
        self.collectionView.registerNib(UINib(nibName: "CollectionAppCell", bundle: nil), forCellWithReuseIdentifier: "CollectionAppCell")
        self.tableView.registerNib(UINib(nibName: "AppCell", bundle: nil), forCellReuseIdentifier: "AppCell")
    }

    
    //MARK : Load Data
    func loadData() {
        //--------------------------------
        // ------ LOAD CORE  DATA  -------
        //--------------------------------
        
        self.apps = DataManager.fetchAppsByCategory(self.category)
        NSLog("APPS: \(self.apps)")
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad  {
            self.collectionView.reloadData()
        } else {
            self.tableView.reloadData()
        }
    }
    
    //MARK : TableView DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AppCell", forIndexPath: indexPath) as! AppCell
        
        //        cell.backgroundColor = UIColor(hex: "#020617")
        cell.contentView.backgroundColor = UIColor.clearColor()
        
        let app = apps[indexPath.row] as App
        
        cell.configure(app)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("SELECTED: \(indexPath.row)")
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("App") as! AppViewController
        vc.transitioningDelegate = self
        vc.app = apps[indexPath.row]
        self.navigationController?.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    
    
    //MARK : CollectionView DataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionAppCell", forIndexPath: indexPath) as! CollectionAppCell
        
        //        cell.backgroundColor = UIColor(hex: "#020617")
        cell.contentView.backgroundColor = UIColor.clearColor()
        
        let app = apps[indexPath.row] as App
        
        cell.configure(app)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        NSLog("SELECTED: \(indexPath.row)")
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("App") as! AppViewController
        vc.transitioningDelegate = self
        vc.app = apps[indexPath.row]
        self.navigationController?.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customDismissAnimationController
    }
}

