//
//  MediaItemController.swift
//  MediaManager
//
//  Created by Benjamin Prentiss on 1/9/23.
//

import CoreData

class MediaItemController {
    
    static let shared = MediaItemController()

    var mediaItems: [MediaItem] = []
    var favorites: [MediaItem] = []
    var movies: [MediaItem] = []
    var tvShows: [MediaItem] = []
    var sections: [[MediaItem]] { [favorites, movies, tvShows] }

    private lazy var fetchRequest: NSFetchRequest<MediaItem> = {
       let request = NSFetchRequest<MediaItem>(entityName: "MediaItem")
       request.predicate = NSPredicate(value: true)
       return request
    }()

    func fetchMediaItems() {
       favorites = []
       movies = []
       tvShows = []
       let mediaItems = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
       self.mediaItems = mediaItems
       sectionOffMediaItems()
    }

    func sectionOffMediaItems() {
       for i in mediaItems {
          if i.isFavorite {
             favorites.append(i)
          }
          if i.mediaType == "Movie" {
             movies.append(i)
          } else if i.mediaType == "TV Show" {
             tvShows.append(i)
          }
       }
    }

    func createMediaItem(title: String, mediaType: String, year: Int, itemDescription: String, rating: Double, wasWatched: Bool, isFavorite: Bool) {

       let mediaItem = MediaItem(title: title, mediaType: mediaType, year: year, itemDescription: itemDescription, rating: rating, wasWatched: wasWatched, isFavorite: isFavorite)

       mediaItems.append(mediaItem)

       CoreDataStack.saveContext()
       fetchMediaItems()
    }
 }


