//
//  NewBookView.swift
//  Books
//
//  Created by Eduardo Bertol on 02/10/25.
//

import Foundation
import UIKit

class NewBookView: UIView {
    
    //MARK: - Subviews
    private(set) lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: "placeholder")
        
        imageView.layer.masksToBounds = false
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.35
        imageView.layer.shadowOffset = CGSize(width: -3, height: 4)
        imageView.layer.shadowRadius = 5

        
        return imageView
    }()
    
    //TODO: Criar um rect do tamanho do Livro
    
    
    private(set) lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.textColor = .black
        textField.textAlignment = .left
        textField.placeholder = "type the title..."
        
        return textField
    }()
    
    private(set) lazy var authorTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        textField.textColor = .black
        textField.textAlignment = .right
        textField.placeholder = "type the author..."
        
        return textField
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
    
    private(set) lazy var reviewTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        textField.textColor = .black
        textField.textAlignment = .left
        textField.placeholder = "type the review..."
        
        return textField
    }()
    
    private(set) lazy var saveButton: UIButton = {
        let button = labelButton(width: 64, height: 35, text: "done", fontSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    //MARK: - Subviews Funcs

    func labelButton(width: CGFloat, height: CGFloat, text: String, fontSize: CGFloat) -> UIButton {
        var isActive: Bool = false
        
        let button = squareButton(width: width, height: height)
        
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: fontSize, weight: .regular)
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = isActive ? .sOrange : .sBege
        
//        let action = UIAction { [weak self] _ in
        let action = UIAction { _ in
            isActive = !isActive
            button.backgroundColor = isActive ? .sOrange : .sBege
        }
        
        button.addAction(action, for: .touchUpInside)
        
        return button
    }
    
    func squareButton(width: CGFloat, height: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.backgroundColor = .sOrange
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: width),
            button.heightAnchor.constraint(equalToConstant: height),
        ])
        
        return button
    }

    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
//        setup(book)
        addSubViews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Methods
    
//    private func setup(_ book: Book) {
//        bookImage.image = UIImage(named: book.imageName)
//        titleTextField.text = book.title
//        authorTextField.text = book.author
//        reviewTextField.text = book.review
//    }
    
    
    private func addSubViews() {
        addSubview(bookImage)
        addSubview(titleTextField)
        addSubview(authorTextField)
        addSubview(reviewLabelIndicator)
        addSubview(reviewRect)
        addSubview(reviewTextField)
        addSubview(saveButton)
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
            titleTextField.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: innerPadding + 8),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
            
            //title - author: 4
            authorTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 4),
            authorTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
            authorTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
            
            //authon - review: 16
            reviewLabelIndicator.topAnchor.constraint(equalTo: authorTextField.bottomAnchor, constant: innerPadding),
            reviewLabelIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
            reviewLabelIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
            
            reviewRect.topAnchor.constraint(equalTo: reviewLabelIndicator.bottomAnchor, constant: 8),
            reviewRect.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
            reviewRect.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
            reviewRect.heightAnchor.constraint(equalTo: reviewTextField.heightAnchor, constant: 32),
            
            reviewTextField.topAnchor.constraint(equalTo: reviewLabelIndicator.bottomAnchor, constant: 20),
            reviewTextField.leadingAnchor.constraint(equalTo: reviewRect.leadingAnchor, constant: 12),
            reviewTextField.trailingAnchor.constraint(equalTo: reviewRect.trailingAnchor, constant: -12),
            
            
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
