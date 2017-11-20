//
//  MovieModel+CoreDataProperties.swift
//  MoviesDemo
//
//  Created by Shrimant Nikate on 17/11/17.
//  Copyright © 2017 Shrimant Nikate. All rights reserved.
//

import Foundation
import CoreData


extension MovieModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieModel> {
        return NSFetchRequest<MovieModel>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var rating: Double
    @NSManaged public var image: NSData?
    @NSManaged public var genre: NSSet?
    @NSManaged public var releaseYear: Int
}

// MARK: Generated accessors for genre
extension MovieModel {

    @objc(addGenreObject:)
    @NSManaged public func addToGenre(_ value: GenreModel)

    @objc(removeGenreObject:)
    @NSManaged public func removeFromGenre(_ value: GenreModel)

    @objc(addGenre:)
    @NSManaged public func addToGenre(_ values: NSSet)

    @objc(removeGenre:)
    @NSManaged public func removeFromGenre(_ values: NSSet)

}
