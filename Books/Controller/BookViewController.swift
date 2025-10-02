//
//  BookViewController.swift
//  Books
//
//  Created by Eduardo Bertol on 01/10/25.
//

import Foundation
import UIKit

class BookViewController: UIViewController {
    
    // MARK: - Properties
    private let bookView: BookView
    private let book: Book
    
    init(book: Book) {
        self.book = book
        bookView = BookView(book: book)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("use init(user:)")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = bookView
        
        view.backgroundColor = .sBege
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //      navigationItem.title = user.name
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //      userView.goBatshitCrazy()
    }
    
    // MARK: - Setup Methods
}
