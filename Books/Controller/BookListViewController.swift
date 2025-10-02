//
//  ViewController.swift
//  Books
//
//  Created by Eduardo Bertol on 01/10/25.
//

import UIKit

class BookListViewController: UIViewController {

    private let bookListView = BookListView()
    private let books = Book.mockBooks()
    
    override func loadView() {
        super.loadView()
        super.view = bookListView
        
        view.backgroundColor = .sBege
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookListView.delegate = self
        
        bookListView.bookListCollectionView.dataSource = self
        bookListView.bookListCollectionView.delegate = self
    }

    func didTapPlusButton() {
        
    }

}

extension BookListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "BookListCell",
            for: indexPath
        ) as? BookListCell else { fatalError("Could not create new cell")
        }
        
        cell.setup(with: books[indexPath.row])
        
        return cell
    }
}

extension BookListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width - 48
        
        return CGSize(width: width, height: 60)
//        return CGSize(width: 100, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let clickedBook = books[indexPath.row]
        
        let bookVC = BookViewController(book: clickedBook)
        present(bookVC, animated: true)
//        navigationController?.pushViewController(bookVC, animated: true)
    }
}

extension BookListViewController: BookListViewDelegate{
    func didTapAddButton() {
        //add book
        print("add book")
    }
    
    
}

