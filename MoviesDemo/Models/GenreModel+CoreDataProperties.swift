//
//  GenreModel+CoreDataProperties.swift
//  MoviesDemo
//
//  Created by Shrimant Nikate on 17/11/17.
//  Copyright © 2017 Shrimant Nikate. All rights reserved.
//

import Foundation
import CoreData


extension GenreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenreModel> {
        return NSFetchRequest<GenreModel>(entityName: "Genre")
    }

    @NSManaged public var type: String?
    @NSManaged public var movie: NSSet?

}

// MARK: Generated accessors for movie
extension GenreModel {

    @objc(addMovieObject:)
    @NSManaged public func addToMovie(_ value: MovieModel)

    @objc(removeMovieObject:)
    @NSManaged public func removeFromMovie(_ value: MovieModel)

    @objc(addMovie:)
    @NSManaged public func addToMovie(_ values: NSSet)

    @objc(removeMovie:)
    @NSManaged public func removeFromMovie(_ values: NSSet)

}
