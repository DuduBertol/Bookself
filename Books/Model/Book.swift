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
            title: "Breves Respostar para Grandes Questões e Breves Respostar para Grandes Questões",
            author: "Stephen Hawking",
            imageName: "Hawking",
            review: "Esse livro é legal :))) \n Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
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
