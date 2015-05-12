//
//  UpdateViewController.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 1/7/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "updateCell"
        
        var cell:UpdateStoreTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as! UpdateStoreTableViewCell
        if (cell == nil)
        {
            cell = UpdateStoreTableViewCell()
            
        }
        
//        cell.updateBtn.layer.borderColor = cell.up.textColor.CGColor
//        cell.priceBtn.layer.borderWidth = 1.0
//        cell.priceBtn.layer.cornerRadius = cell.priceBtn.frame.size.height / 8
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
