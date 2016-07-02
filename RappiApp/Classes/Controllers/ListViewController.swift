//
//  ListViewController.swift
//  RappiApp
//
//  Created by Carlos Alcala on 6/10/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    //MARK : IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK : Properties
    
    var apps:[String] = ["App 1", "App 2", "App 3"]
    
    //MARK : ViewController Lifetime
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    //MARK : Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.configureUI()
        
        //load API data
        self.loadData()
    }
    
    //MARK : Controller Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureUI() {
        //        self.view.backgroundColor = UIColor(hex: "#020617")
        self.tableView.backgroundColor = UIColor.clearColor()
        self.collectionView.backgroundColor = UIColor.clearColor()
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad  {
            tableView.hidden = true
            collectionView.hidden = false
        } else {
            tableView.hidden = false
            collectionView.hidden = true
        }
    }
    
    
    //MARK : Load Data
    func loadData() {
        
        self.collectionView.reloadData()
        self.tableView.reloadData()
    }
    
    //MARK : TableView DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AppCell", forIndexPath: indexPath) 
        
        //        cell.backgroundColor = UIColor(hex: "#020617")
        cell.contentView.backgroundColor = UIColor.clearColor()
        
        let category = apps[indexPath.row] as String
        
        cell.textLabel?.text = category
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("SELECTED: \(indexPath.row)")
        
        //        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Alarm") as! AlarmViewController
        //        vc.modalTransitionStyle = .CrossDissolve
        //        vc.alarm = apps[indexPath.row]
        //        vc.isUpdating = true
        //        self.navigationController?.pushViewController(vc, animated: true)
        
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
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AppCollectionCell", forIndexPath: indexPath)
        
        //        cell.backgroundColor = UIColor(hex: "#020617")
        cell.backgroundColor = UIColor.yellowColor()
        
        //        let category = categories[indexPath.row] as Category
        //
        //        cell.textLabel?.text = category.name
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        NSLog("SELECTED: \(indexPath.row)")
    }
    
    
    
}

