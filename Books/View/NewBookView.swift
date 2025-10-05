//
//  NewBookView.swift
//  Books
//
//  Created by Eduardo Bertol on 02/10/25.
//

import Foundation
import UIKit

protocol NewBookViewDelegate: AnyObject {
    //Create
    func didTapAddCover()
    
    //Update
    func didTapOptionsButton()
    func didTapEditButton()
    
    //Delete
    func didTapDeleteButton()
    
    //Save
    func didTapDoneButton()
}


enum BookViewState {
    case create, update, read, delete
}


class NewBookView: UIView {
    
    weak var delegate: NewBookViewDelegate?
    
    private var keyboardFields: [UIView] = []
    
    var state = BookViewState.create {
        didSet { updateUI(for: state) }
    }
    
    //MARK: - Subviews
    
    //Cover
    private(set) lazy var coverButton: UIButton = {
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
    
    //Title
    private(set) lazy var titleTextField: UITextField = CustomTextField(fontSize: 18, placeholderText: "type the title...")
    
    //Author
    private(set) lazy var authorTextField: UITextField = CustomTextField(fontSize: 14, placeholderText: "type the author...", alignment: .right)
    
    //Review
    private(set) lazy var reviewLabelIndicator: UILabel = CustomLabelIndicator(fontSize: 10, text: "Review")
    private(set) lazy var reviewRect: UIView = CustomRect()
    private(set) lazy var reviewTextField: UITextField = CustomTextField(fontSize: 12, placeholderText: "type the review...")
    
    //Save Button
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
    
    
    init(book: Book? = nil) {
        super.init(frame: .zero)
        
        setup(book: book)
        addSubViews()
        setupConstraints()
        
        configureKeyboardNavigation(fields: [titleTextField, authorTextField, reviewTextField])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Methods
    
    private func setup(book: Book?) {
        guard let book else {
            state = .create
            return
        }
        
        state = .read
        coverButton.setImage(book.cover, for: .normal)
        titleTextField.text = book.title
        authorTextField.text = book.author
        reviewTextField.text = book.review
    }
    
    private func addSubViews() {
        addSubview(coverButton)
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
            coverButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            coverButton.topAnchor.constraint(equalTo: topAnchor, constant: outterPadding),
            coverButton.widthAnchor.constraint(equalToConstant: 150),
            coverButton.heightAnchor.constraint(equalToConstant: 225),
            
            //image - title: 16
            titleTextField.topAnchor.constraint(equalTo: coverButton.bottomAnchor, constant: innerPadding + 8),
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
    
    //MARK: - Other Setup Methods
    
//    private func initialSetup() {
//        bookImage.image = UIImage(named: "placeholder")
//        titleTextField.placeholder = "type the title..."
//        authorTextField.text = "type the author..."
//        reviewTextField.text = "type the review"
//    }
    
    private func updateUI(for state: BookViewState) {
        switch state {
        case .create:
            coverButton.isEnabled = true
            titleTextField.isEnabled = true
            authorTextField.isEnabled = true
            reviewTextField.isEnabled = true
            saveButton.isHidden = false

        case .read:
            coverButton.isEnabled = false
            titleTextField.isEnabled = false
            authorTextField.isEnabled = false
            reviewTextField.isEnabled = false
            saveButton.isHidden = true

        case .update:
            coverButton.isEnabled = true
            titleTextField.isEnabled = true
            authorTextField.isEnabled = true
            reviewTextField.isEnabled = true
            saveButton.isHidden = false

        case .delete:
            // talvez exibir alerta ou deixar tudo cinza
            break
        }
    }

    
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
}
