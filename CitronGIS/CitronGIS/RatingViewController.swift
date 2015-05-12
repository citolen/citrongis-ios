//
//  RatingViewController.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 1/6/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "ratingCell"
        
        var cell:RatingStoreTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as! RatingStoreTableViewCell
        if (cell == nil)
        {
            cell = RatingStoreTableViewCell()
            
//                [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.numberLabel.text = String(indexPath.row + 1)
        cell.priceBtn.layer.borderColor = cell.numberLabel.textColor.CGColor
        cell.priceBtn.layer.borderWidth = 1.0
        cell.priceBtn.layer.cornerRadius = cell.priceBtn.frame.size.height / 8
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
