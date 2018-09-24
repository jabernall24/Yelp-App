//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var businesses: [Business]!
    let searchBar = UISearchBar()
    
    var searched: String!
    
    var offset = 0
    
    var filteredData: [String]!
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        
        performSearch()
}
    
    func performSearch(){
        if searched == nil{
            searched = "Thai"
        }
        Business.searchWithTerm(term: searched, completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            if let businesses = businesses {
                for business in businesses {
                    self.tableView.reloadData()
                    print(business.name!)
                    print(business.address!)
                }
            }
        })
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let  height = scrollView.frame.size.height
//        let contentYoffset = scrollView.contentOffset.y
//        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
//        if distanceFromBottom < height {
//
//
//        }
//    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searched = searchBar.text ?? "Thai"
        performSearch()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searched = searchBar.text!
        performSearch()
        searchBar.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil{
            return businesses.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }
}
