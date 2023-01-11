//
//  MediaItem+Convenience.swift
//  MediaManager
//
//  Created by Benjamin Prentiss on 1/9/23.
//

import CoreData

extension MediaItem {
    @discardableResult convenience init (title: String, mediaType: String, year: Int, itemDescription:    String, rating: Double, wasWatched: Bool, isFavorite: Bool, reminderDate: Date? = nil, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.id = UUID()
        self.title = title
        self.mediaType = mediaType
        self.year = Int64(year)
        self.itemDescription = itemDescription
        self.rating = rating
        self.wasWatched = wasWatched
        self.isFavorite = isFavorite
        self.reminderDate = reminderDate
        
    }
}
