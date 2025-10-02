//
//  BookCell.swift
//  Books
//
//  Created by Eduardo Bertol on 01/10/25.
//

import Foundation
import UIKit

class BookListCell: UICollectionViewCell {
    
    
    
    // MARK: - Subviews
    private(set) lazy var borderRect: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.black.cgColor
        
        return view
    }()
    
    private(set) lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: "placeholder")
        
        return imageView
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    func setup(with book: Book){
        bookImage.image = UIImage(named: book.imageName)
    }
    
    private func addSubViews() {
        addSubview(borderRect)
        addSubview(bookImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            bookImage.widthAnchor.constraint(equalToConstant: 100), //2/3
            bookImage.heightAnchor.constraint(equalToConstant: 150),
            
            borderRect.centerXAnchor.constraint(equalTo: bookImage.centerXAnchor),
            borderRect.centerYAnchor.constraint(equalTo: bookImage.centerYAnchor),
            borderRect.widthAnchor.constraint(equalTo: bookImage.widthAnchor, constant: 8),
            borderRect.heightAnchor.constraint(equalTo: bookImage.heightAnchor, constant: 8),
        ])
    }
}
