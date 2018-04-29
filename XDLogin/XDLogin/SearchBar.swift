//
//  SearchBar.swift
//  mapView
//
//  Created by student on 4/22/18.
//  Copyright © 2018 The-Windows-Specialists. All rights reserved.
//

import UIKit
class LocationSearchTable : UITableViewController {
    // Search Controller property
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Search results table
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
    }
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("Success\n")
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
    }
}

