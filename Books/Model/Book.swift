//
//  Book.swift
//  Books
//
//  Created by Eduardo Bertol on 01/10/25.
//

import Foundation
struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let imageName: String
    let review: String
    let state: BookState
}

extension Book {
    static func mockBooks() -> [Book] {[
        Book(
            title: "Breves Respostar para Grandes Questões",
            author: "Stephen Hawking",
            imageName: "Hawking",
            review: "Esse livro é legal :)))",
            state: .done
        ),
        Book(
            title: "Nada Pode Me Ferir",
            author: "David Goggins",
            imageName: "NadaPodeMeFerir",
            review: "esse é mtt foda slk",
            state: .favs
        ),
        Book(
            title: "Breves Respostar para Grandes Questões",
            author: "Stephen Hawking",
            imageName: "Hawking",
            review: "Esse livro é legal :)))",
            state: .done
        ),
        Book(
            title: "Nada Pode Me Ferir",
            author: "David Goggins",
            imageName: "NadaPodeMeFerir",
            review: "esse é mtt foda slk",
            state: .favs
        ),
        Book(
            title: "Breves Respostar para Grandes Questões",
            author: "Stephen Hawking",
            imageName: "Hawking",
            review: "Esse livro é legal :)))",
            state: .done
        ),
        Book(
            title: "Nada Pode Me Ferir",
            author: "David Goggins",
            imageName: "NadaPodeMeFerir",
            review: "esse é mtt foda slk",
            state: .favs
        ),
        Book(
            title: "Breves Respostar para Grandes Questões",
            author: "Stephen Hawking",
            imageName: "Hawking",
            review: "Esse livro é legal :)))",
            state: .done
        ),
        Book(
            title: "Nada Pode Me Ferir",
            author: "David Goggins",
            imageName: "NadaPodeMeFerir",
            review: "esse é mtt foda slk",
            state: .favs
        ),
        Book(
            title: "Breves Respostar para Grandes Questões",
            author: "Stephen Hawking",
            imageName: "Hawking",
            review: "Esse livro é legal :)))",
            state: .done
        ),
        Book(
            title: "Nada Pode Me Ferir",
            author: "David Goggins",
            imageName: "NadaPodeMeFerir",
            review: "esse é mtt foda slk",
            state: .favs
        ),
        Book(
            title: "Breves Respostar para Grandes Questões",
            author: "Stephen Hawking",
            imageName: "Hawking",
            review: "Esse livro é legal :)))",
            state: .done
        ),
        Book(
            title: "Nada Pode Me Ferir",
            author: "David Goggins",
            imageName: "NadaPodeMeFerir",
            review: "esse é mtt foda slk",
            state: .favs
        ),
    ]}
}

enum BookState: String, Codable {
    case favs, now, done, want
}
