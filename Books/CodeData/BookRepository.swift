//
//  BookRepository.swift
//  Books
//
//  Created by Eduardo Bertol on 02/10/25.
//

import Foundation
import CoreData
import UIKit

final class BookRepository {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataStack.shared.viewContext) {
        self.context = context
    }

    // Create from struct
    @discardableResult
    func create(from book: Book) -> BookEntity {
        let entity = book.toEntity(context: context)
        
        if let img = book.cover {
            // compress + convert to Data
            if let data = img.jpegData(compressionQuality: 0.8) {
                entity.cover = data
            }
        }
        
        save()
        return entity
    }

    // Create with fields
    @discardableResult
    func create(title: String,
                author: String?,
                review: String?,
                rating: Int = 0,
                coverImage: UIImage? = nil) -> BookEntity {
        let entity = BookEntity(context: context)
        entity.id = UUID()
        entity.title = title
        entity.author = author
        entity.review = review
        entity.rating = Int16(rating)
        if let img = coverImage, let data = img.jpegData(compressionQuality: 0.8) {
            entity.cover = data
        }
        entity.createdAt = Date()
        save()
        return entity
    }

    // Read
    func fetchAll(sortedBy sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(key: "title", ascending: true)]) -> [BookEntity] {
        let req: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        req.sortDescriptors = sortDescriptors
        do { return try context.fetch(req) } catch {
            print("Fetch error: \(error)")
            return []
        }
    }

    func fetch(by predicate: NSPredicate?, sortedBy sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(key: "title", ascending: true)]) -> [BookEntity] {
        let req: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        req.predicate = predicate
        req.sortDescriptors = sortDescriptors
        do { return try context.fetch(req) } catch {
            print("Fetch error: \(error)")
            return []
        }
    }

    // Update given entity
    func update(_ entity: BookEntity,
                title: String,
                author: String?,
                review: String?,
                rating: Int,
                coverImage: UIImage?) {
        entity.title = title
        entity.author = author
        entity.review = review
        entity.rating = Int16(rating)
        if let img = coverImage, let data = img.jpegData(compressionQuality: 0.8) {
            entity.cover = data
        }
        save()
    }

    // Update from struct (if you want replace)
    func update(entity: BookEntity, from book: Book) {
        entity.title = book.title
        entity.author = book.author
        entity.review = book.review
        entity.rating = Int16(book.rating)
        entity.cover = book.cover?.jpegData(compressionQuality: 0.8)
        entity.createdAt = book.createdAt
        save()
    }

    // Delete
    func delete(_ entity: BookEntity) {
        context.delete(entity)
        save()
    }

    private func save() {
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch {
            context.rollback()
            print("Repository save error: \(error)")
        }
    }
}
