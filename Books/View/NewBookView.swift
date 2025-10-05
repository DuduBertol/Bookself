//
//  NewBookView.swift
//  Books
//
//  Created by Eduardo Bertol on 02/10/25.
//

import Foundation
import UIKit

protocol NewBookViewDelegate: AnyObject {
    func didTapDoneButton()
    func didTapAddCover()
}

class NewBookView: UIView {
    
    weak var delegate: NewBookViewDelegate?
    
    private var keyboardFields: [UIView] = []
    
    //MARK: - Subviews
    
    
//    private(set) lazy var bookImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        imageView.image = UIImage(named: "placeholder")
//        
//        imageView.layer.masksToBounds = false
//        imageView.layer.shadowColor = UIColor.black.cgColor
//        imageView.layer.shadowOpacity = 0.35
//        imageView.layer.shadowOffset = CGSize(width: -3, height: 4)
//        imageView.layer.shadowRadius = 5
//
//        
//        return imageView
//    }()
    
    private(set) lazy var addCoverButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "placeholder")
        button.setImage(image, for: .normal)
        
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.35
        button.layer.shadowOffset = CGSize(width: -3, height: 4)
        button.layer.shadowRadius = 5
        
        let action = UIAction { _ in
            self.delegate?.didTapAddCover()
        }
        
        button.addAction(action, for: .touchUpInside)
        
        return button
    }()
    
    private(set) lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.textColor = .black
        textField.textAlignment = .left
        textField.placeholder = "type the title..."
        textField.autocorrectionType = .no
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "type the title...",
            attributes: [.foregroundColor: UIColor.sBegeOpaque]
        )
        
        return textField
    }()
    
    private(set) lazy var authorTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        textField.textColor = .black
        textField.textAlignment = .right
        textField.placeholder = "type the author..."
        textField.autocorrectionType = .no
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "type the author...",
            attributes: [.foregroundColor: UIColor.sBegeOpaque]
        )
        
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
    
//    private(set) lazy var reviewTextField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        
//        textField.font = UIFont.systemFont(ofSize: 12, weight: .regular)
//        textField.textColor = .black
//        textField.textAlignment = .left
//        textField.placeholder = "type the review..."
//        textField.autocorrectionType = .no
//        
//        textField.attributedPlaceholder = NSAttributedString(
//            string: "type the review...",
//            attributes: [.foregroundColor: UIColor.sBegeOpaque]
//        )
//        
//        return textField
//    }()
    
    private(set) lazy var reviewTextField: UITextField = CustomTextField(fontSize: 12, placeholderText: "type the review...")
    
    private(set) lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.backgroundColor = .sOrange
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 64),
            button.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        button.setTitle("done", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(.black, for: .normal)
        
        button.backgroundColor = .sOrange
        
//        let action = UIAction { [weak self] _ in
        let action = UIAction { _ in
            self.delegate?.didTapDoneButton()
        }
        
        button.addAction(action, for: .touchUpInside)
        
        
        
        return button
    }()
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
//        initialSetup()
        addSubViews()
        setupConstraints()
        
        configureKeyboardNavigation(fields: [titleTextField, authorTextField, reviewTextField])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Methods
    
//    private func initialSetup() {
//        bookImage.image = UIImage(named: "placeholder")
//        titleTextField.placeholder = "type the title..."
//        authorTextField.text = "type the author..."
//        reviewTextField.text = "type the review"
//    }
    
    func configureKeyboardNavigation(fields: [UIView]) {
        keyboardFields = fields
        
        //ele constrói uma toolbar para cada campo
        for (index, field) in fields.enumerated() {
            let toolbar = makeAcessoryToolbar(forIndex: index)
            if let textField = field as? UITextField {
                textField.inputAccessoryView = toolbar
            } else if let textView = field as? UITextView {
                textView.inputAccessoryView = toolbar
            } else {
                // não é input, pule
            }
            
        }
    }
    
    func makeAcessoryToolbar(forIndex index: Int) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped(_:)))
        
        toolbar.items = [flexible, done]
        return toolbar
        
    }
    
    private func currentFirstResponderIndex() -> Int? {
        for (idx, view) in keyboardFields.enumerated() {
            if view.isFirstResponder {
                return idx
            }
        }
        return nil
    }
    
    @objc private func doneTapped(_ sender: UIBarButtonItem) {
        guard let currentIndex = currentFirstResponderIndex() else {
            self.endEditing(true)
            return
        }

        if currentIndex < keyboardFields.count - 1 {
            keyboardFields[currentIndex + 1].becomeFirstResponder()
        } else {
            endEditing(true)
        }
//        let lastIndex = keyboardFields.count - 1
//
//        if currentIndex < lastIndex {
//            let nextIndex = currentIndex + 1
//            guard nextIndex >= 0 && nextIndex < keyboardFields.count else {
//                self.endEditing(true)
//                return
//            }
//            keyboardFields[nextIndex].becomeFirstResponder()
//        } else {
//            // estou no último campo → fecha o teclado
//            self.endEditing(true)
//            //aqui se eu quisese eu poderia colocar a acao de save
//        }
        
    }
    
    
    private func addSubViews() {
        addSubview(addCoverButton)
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
            addCoverButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addCoverButton.topAnchor.constraint(equalTo: topAnchor, constant: outterPadding),
            addCoverButton.widthAnchor.constraint(equalToConstant: 150),
            addCoverButton.heightAnchor.constraint(equalToConstant: 225),
            
            //image - title: 16
            titleTextField.topAnchor.constraint(equalTo: addCoverButton.bottomAnchor, constant: innerPadding + 8),
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
