//
//  FilterTableViewModel.swift
//  MoviesDemo
//
//  Created by Shrimant Nikate on 19/11/17.
//  Copyright © 2017 Shrimant Nikate. All rights reserved.
//

import UIKit
import CoreData

protocol FilterDelegate {
    func didSelectedFilter(filter:GenreModel?)
}

class FilterTableViewModel: NSObject {
    var GenreFetchResultController: NSFetchedResultsController<GenreModel>!
    var SelectedFilter: GenreModel? = nil
    var filterDelegate: FilterDelegate?
    
    init(delegate: NSFetchedResultsControllerDelegate, selectedFilter: GenreModel?)
    {
        super.init()
        SelectedFilter = selectedFilter
        setupFetchResultController()
        GenreFetchResultController.delegate = delegate
        FetchGenre()
    }
    
    private func setupFetchResultController()
    {
        let contex = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        let request:NSFetchRequest<GenreModel> = GenreModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "type", ascending: true)]
        
        GenreFetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: contex, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    private func FetchGenre(){
        do{
            try GenreFetchResultController.performFetch()
        }
        catch let error {
            print(error)
        }
    }
    
    
    func numberOfCellInSection(section: Int)->Int
    {
        return GenreFetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func numberOfSections()-> Int
    {
        return GenreFetchResultController.sections?.count ?? 0
    }
    
    func setupTableViewCell(cell: UITableViewCell, forIndexPath indexpath:IndexPath) -> UITableViewCell {
        guard let genre = GenreFetchResultController.sections?[indexpath.section].objects?[indexpath.row] as? GenreModel else {
            return cell;
        }
        cell.textLabel?.text = genre.type
        
        cell.isSelected = SelectedFilter != nil
            ? SelectedFilter?.type == genre.type
            : false
        cell.accessoryType = cell.isSelected
            ? UITableViewCellAccessoryType.checkmark
            : UITableViewCellAccessoryType.none
        return cell
    }
    
    func didSelectRowAtIndexPath(indexpath: IndexPath)
    {
        SelectedFilter = GenreFetchResultController.sections?[indexpath.section].objects?[indexpath.row] as? GenreModel
    }
    
    func didDeselectRowAtIndextPath(indexpath:IndexPath)
    {
        SelectedFilter = nil
    }
}
