//
//  NearMeViewController.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 1/6/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import UIKit

class NearMeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "ratingCell"
        
        var cell:RatingStoreTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as RatingStoreTableViewCell
        if (cell == nil)
        {
            cell = RatingStoreTableViewCell()
            
        }
        cell.numberLabel.hidden = true
        cell.priceBtn.layer.borderColor = cell.numberLabel.textColor.CGColor
        cell.priceBtn.layer.borderWidth = 1.0
        cell.priceBtn.layer.cornerRadius = cell.priceBtn.frame.size.height / 8
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }



}
