//
//  FilterTableViewController.swift
//  MoviesDemo
//
//  Created by Shrimant Nikate on 19/11/17.
//  Copyright © 2017 Shrimant Nikate. All rights reserved.
//

import UIKit
import CoreData

class FilterTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    var filterDelegate: FilterDelegate?
    private var viewmodel: FilterTableViewModel!
    var selectedFilter: GenreModel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel = FilterTableViewModel(delegate: self, selectedFilter: selectedFilter)
        viewmodel.filterDelegate = filterDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewmodel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewmodel.numberOfCellInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return viewmodel.setupTableViewCell(cell: cell, forIndexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.visibleCells.map { $0.accessoryType = UITableViewCellAccessoryType.none
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.checkmark
        viewmodel.didSelectRowAtIndexPath(indexpath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.none
        viewmodel.didDeselectRowAtIndextPath(indexpath: indexPath)
    }
    
    @IBAction func dissmissButtonTapped(){
        viewmodel.filterDelegate?.didSelectedFilter(filter: viewmodel.SelectedFilter)
        self.dismiss(animated: true, completion: nil)
    }
}
