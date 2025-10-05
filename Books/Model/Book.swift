//
//  Book.swift
//  Books
//
//  Created by Eduardo Bertol on 01/10/25.
//

import Foundation
import UIKit
import CoreData

//@objc(BookEntity)
//public class BookEntity: NSManagedObject { }
//
//extension BookEntity {
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
//        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
//    }
//
//    @NSManaged public var id: UUID?
//    @NSManaged public var title: String?
//    @NSManaged public var author: String?
//    @NSManaged public var review: String?
//    @NSManaged public var rating: Int16
//    @NSManaged public var cover: Data?
//    @NSManaged public var createdAt: Date?
//}


struct Book: Identifiable {
    let id: UUID
    let title: String
    let author: String?
    let review: String?
    let rating: Int
    let cover: UIImage?
    let createdAt: Date
}

extension BookEntity {
    func toStruct() -> Book {
        Book(
            id: self.id ?? UUID(),
            title: self.title ?? "Sem título",
            author: self.author,
            review: self.review,
            rating: Int(self.rating),
            cover: self.cover.flatMap { UIImage(data: $0) },
            createdAt: self.createdAt ?? Date()
        )
    }
}

extension Book {
    func toEntity(context: NSManagedObjectContext) -> BookEntity {
        let entity = BookEntity(context: context)
        entity.id = id
        entity.title = title
        entity.author = author
        entity.review = review
        entity.rating = Int16(rating)
        entity.cover = cover?.jpegData(compressionQuality: 0.8)
        entity.createdAt = createdAt
        return entity
    }
}


extension Book {
    static func emptyBook() -> Book {
        Book(
            id: UUID(),
            title: "",
            author: nil,
            review: nil,
            rating: 0,
            cover: nil,
            createdAt: Date()
        )
    }
    
    static func mockBooks() -> [Book] {[
//        Book(
//            title: "Breves Respostar para Grandes Questões e Breves Respostar para Grandes Questões",
//            author: "Stephen Hawking",
//            imageName: "Hawking",
//            review: "Esse livro é legal :))) \n Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
//            state: .done
//        ),
//        Book(
//            title: "Nada Pode Me Ferir",
//            author: "David Goggins",
//            imageName: "NadaPodeMeFerir",
//            review: "esse é mtt foda slk",
//            state: .favs
//        ),
    ]}
}

enum BookState: String, Codable {
    case favs, now, done, want
}
