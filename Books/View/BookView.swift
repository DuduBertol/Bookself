//
//  BookView.swift
//  Books
//
//  Created by Eduardo Bertol on 01/10/25.
//

import Foundation
import UIKit

class BookView: UIView {
    
    //MARK: - Subviews
    private(set) lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    //MARK: - Initializers
    init(book: Book) {
        super.init(frame: .zero)
        
        addSubViews()
        setupConstraints()
        
        bookImage.image = UIImage(named: book.imageName)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Methods
    private func addSubViews() {
        addSubview(bookImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookImage.topAnchor.constraint(equalTo: topAnchor, constant: 48),
            bookImage.widthAnchor.constraint(equalToConstant: 100),
            bookImage.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
}
