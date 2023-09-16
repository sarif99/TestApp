//
//  MovieEntity+CoreDataProperties.swift
//  MovieList
//
//  Created by Shehroz Arif on 11/09/2023.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var title: String
    @NSManaged public var releaseDate: String?
    @NSManaged public var posterPath: String?
    @NSManaged public var popularity: Int32
    @NSManaged public var id: Int32

}

extension MovieEntity : Identifiable {

}
