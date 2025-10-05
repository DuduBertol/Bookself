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
        
        imageView.layer.masksToBounds = false
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.35
        imageView.layer.shadowOffset = CGSize(width: -3, height: 4)
        imageView.layer.shadowRadius = 5

        
        return imageView
    }()
    
    private(set) lazy var optionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        
        let action = UIAction { _ in
            //option menu
        }
        
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
//        label.text = "temp"

//        label.font = UIFont(name: "Stardew Valley", size: 32)
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var reviewLabelIndicator: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Review"
        
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var reviewRect: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.black.cgColor
        
        return view
    }()
    
    private(set) lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        label.textAlignment = .justified
        label.numberOfLines = 0
        
        return label
    }()
    
    //MARK: - Subviews Funcs
    func borderRect() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.black.cgColor
        
        return view
    }

    
    //MARK: - Initializers
    init(book: Book) {
        super.init(frame: .zero)
        
        setup(book)
        addSubViews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Methods
    
    private func setup(_ book: Book) {
//        bookImage.image = UIImage(named: book.imageName)
        bookImage.image = book.cover
        titleLabel.text = book.title
        authorLabel.text = book.author
        reviewLabel.text = book.review
    }
    
    
    private func addSubViews() {
        addSubview(bookImage)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(reviewLabelIndicator)
        addSubview(reviewRect)
        addSubview(reviewLabel)
    }
    
    private func setupConstraints() {
        
        let innerPadding: CGFloat = 16
        let outterPadding: CGFloat = 32
        
        NSLayoutConstraint.activate([
            bookImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookImage.topAnchor.constraint(equalTo: topAnchor, constant: outterPadding),
            bookImage.widthAnchor.constraint(equalToConstant: 150),
            bookImage.heightAnchor.constraint(equalToConstant: 225),
            
            //image - title: 16
            titleLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: innerPadding + 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
            
            //title - author: 4
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
            
            //authon - review: 16
            reviewLabelIndicator.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: innerPadding),
            reviewLabelIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
            reviewLabelIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
            
            reviewRect.topAnchor.constraint(equalTo: reviewLabelIndicator.bottomAnchor, constant: 8),
            reviewRect.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
            reviewRect.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
            reviewRect.heightAnchor.constraint(equalTo: reviewLabel.heightAnchor, constant: 32),
            
//            reviewLabel.centerYAnchor.constraint(equalTo: reviewRect.centerYAnchor),
//            reviewLabel.centerXAnchor.constraint(equalTo: reviewRect.centerXAnchor),
            reviewLabel.topAnchor.constraint(equalTo: reviewLabelIndicator.bottomAnchor, constant: 20),
            reviewLabel.leadingAnchor.constraint(equalTo: reviewRect.leadingAnchor, constant: 12),
            reviewLabel.trailingAnchor.constraint(equalTo: reviewRect.trailingAnchor, constant: -12),
        ])
    }
}
