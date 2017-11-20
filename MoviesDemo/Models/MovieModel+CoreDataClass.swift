//
//  MovieModel+CoreDataClass.swift
//  MoviesDemo
//
//  Created by Shrimant Nikate on 17/11/17.
//  Copyright © 2017 Shrimant Nikate. All rights reserved.
//

import Foundation
import CoreData

@objc(MovieModel)
public class MovieModel: NSManagedObject {
    
    func getGenresInString()->String? {
        guard let genres = genre as? Set<GenreModel> else {
            return nil
        }
        return genres.flatMap { $0.type }.joined(separator: ",")
    }
}
