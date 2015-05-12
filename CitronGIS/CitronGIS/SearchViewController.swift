//
//  SearchViewController.swift
//  CitronGIS
//
//  Created by Charly DELAROCHE on 1/6/15.
//  Copyright (c) 2015 Charly DELAROCHE. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    var currentSearch = ""
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.bounds.size.height, tableView.frame.size.width, 40))
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action:"doneButtonAction")
        toolBar.items = [spacer, doneButton]
        searchBar.inputAccessoryView = toolBar
    }

    
    func doneButtonAction()
    {
        self.searchBar.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        currentSearch = searchText
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        return true
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        return true
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "ratingCell"
        
        var cell:RatingStoreTableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier) as! RatingStoreTableViewCell
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
