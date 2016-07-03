//
//  CategoriesViewController.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/1/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {

    //MARK : IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK : Properties
    
    let customNavigationAnimationController = CustomNavigationAnimationController()
    let customInteractionController = CustomInteractionController()

    var categories:[String] = []
    
    //MARK : ViewController Lifetime
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    //MARK : Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //transition delegate
        self.navigationController?.delegate = self
        
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
        //--------------------------------
        // ------ LOAD CORE  DATA  -------
        //--------------------------------
        
        self.categories = DataManager.fetchCategories()
        NSLog("CATEGORIES: \(self.categories)")
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
        
        let category = categories[indexPath.row] as String
        
        cell.textLabel?.text = category
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("SELECTED: \(indexPath.row)")
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("List") as! ListViewController
        vc.category = categories[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK : Transitions
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .Push {
            customInteractionController.attachToViewController(toVC)
        }
        customNavigationAnimationController.reverse = operation == .Pop
        return customNavigationAnimationController
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return customInteractionController.transitionInProgress ? customInteractionController : nil
    }
}
