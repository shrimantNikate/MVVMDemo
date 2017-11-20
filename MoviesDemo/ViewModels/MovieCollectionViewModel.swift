//
//  MovieCollectionViewModel.swift
//  MoviesDemo
//
//  Created by Shrimant Nikate on 17/11/17.
//  Copyright © 2017 Shrimant Nikate. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON
import SDWebImage

struct movieTest
{
    var title: String?
    var releaseYear: String?
    var rating: Double
}

class MovieCollectionViewModel: NSObject, FilterDelegate {
    
    private var ReloadCollection:(()->Void)? = nil
    var MovieFetchResultController: NSFetchedResultsController<MovieModel>!
    var selectedGenre: GenreModel? = nil {
        didSet {
            if (MovieFetchResultController != nil)
            {
                guard let genereType = selectedGenre?.type else {
                    MovieFetchResultController.fetchRequest.predicate = nil
                    FetchMovies()
                    return
                }
                MovieFetchResultController.fetchRequest.predicate = NSPredicate(format: "Any genre.type contains[c] %@",genereType)
                FetchMovies()
            }
        }
    }
    
    init(reloadCollection:@escaping ()->Void, delegate: NSFetchedResultsControllerDelegate)
    {
        super.init()
        ReloadCollection = reloadCollection
        LoadMovies()
        setupFetchResultController()
        MovieFetchResultController.delegate = delegate
        FetchMovies()
    }
    
    private func setupFetchResultController()
    {
        let contex = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        let request:NSFetchRequest<MovieModel> = MovieModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        request.fetchBatchSize = 5
        
        MovieFetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: contex, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    private func FetchMovies(){
        do{
            try MovieFetchResultController.performFetch()
            ReloadCollection?()
        }
        catch let error {
            print(error)
        }
    }
    
    private func LoadMovies()
    {
        MovieService.fetchData(fromSavedUrl: "https://api.androidhive.info/json/movies.json") { (JSON, ERROR) in
            guard let json = JSON  else {
                return
            }
            self.SaveMoviesFrom(jsonArry: json)
        }
    }
    
    func numberOfCellInSection(section: Int)->Int
    {
        return MovieFetchResultController.sections?[section].numberOfObjects ?? 0
    }
    
    func numberOfSectionInCollection()-> Int
    {
        return MovieFetchResultController.sections?.count ?? 0
    }
    
    func setupMovieCollectionViewCell(cell: MovieCollectionViewCell, forIndexPath indexpath:IndexPath) -> MovieCollectionViewCell {
        guard let movie = MovieFetchResultController.sections?[indexpath.section].objects?[indexpath.row] as? MovieModel else {
            return cell;
        }
        cell.SetupCellUI(movie: movie)
        return cell
    }
    
    private func createMovieEntityFrom(json:JSON)->MovieModel?
    {
        let context = CoreDataStack.sharedInstance.mainContext
        if let MovieEntity = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context) as? MovieModel
        {
            MovieEntity.title = json["title"].string
            MovieEntity.rating = json["rating"].double ?? 0.0
            MovieEntity.releaseYear = json["releaseYear"].int ?? 0
            MovieEntity.imageUrl = json["image"].string
            
            if let genrs = json["genre"].array
            {
                for type in genrs {
                    if let GenreEntity = NSEntityDescription.insertNewObject(forEntityName: "Genre", into: context) as? GenreModel
                    {
                        GenreEntity.type = type.string
                        MovieEntity.addToGenre(GenreEntity)
                    }
                }
            }
            return MovieEntity
        }
        return nil
    }
    
    private func SaveMoviesFrom(jsonArry: JSON)
    {
        guard let array = jsonArry.array else {
            return
        }
        
        let _ = array.map{ createMovieEntityFrom(json: $0) }
        do{
            try CoreDataStack.sharedInstance.mainContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func didSelectedFilter(filter: GenreModel?) {
        selectedGenre = filter
    }
}
