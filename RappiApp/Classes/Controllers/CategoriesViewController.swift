//
//  CategoriesViewController.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit
import RealmSwift

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK : IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK : Properties
    
    var categories:[Category] = []
//    var categories:[String] = ["Cat 1", "Cat 2", "Cat 3"]
    
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
    }

    
    //MARK : Load Data
    func loadData() {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // used Realm to retrieve objects from DB
        // data is always retrieved from DB and not directly from API callback
        // this way we can ALWAYS display the apps from last API data cache
        
        let realm = try! Realm()
        
        do {
            try realm.write() {
                
                realm.refresh()
                categories = Array(realm.objects(Category.self))
                
            }
        } catch let error as NSError  {
            print("Error: \(error), \(error.userInfo)")
        }
        
        
        
        
        print("CATEGORIES: \(categories)")
        
//let temp = realm.objects(App.self).filter("name BEGINSWITH 'P'")
//        let categories = Array(temp)
//
//        NSLog("CATEGORIES: \(categories)")
//        
        for cat in categories {
            print("NAME: \(cat.name)")
        }
        
        
        self.tableView.reloadData()
    }
    
    //MARK : TableView DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath)
        
//        cell.backgroundColor = UIColor(hex: "#020617")
        cell.contentView.backgroundColor = UIColor.clearColor()
        
        let category = categories[indexPath.row] as Category
//        let category = categories[indexPath.row] as String
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("SELECTED: \(indexPath.row)")
        
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Alarm") as! AlarmViewController
//        vc.modalTransitionStyle = .CrossDissolve
//        vc.alarm = categories[indexPath.row]
//        vc.isUpdating = true
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //MARK : Actions

}
