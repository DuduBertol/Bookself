/*
 
 
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
     
     private(set) lazy var titleLabelIndicator: UILabel = labelIndicator(text: "Title")
     private(set) lazy var titleRect: UIView = rectIndicator()
     private(set) lazy var titleTextField: UITextField = {
         let textField = UITextField()
         textField.translatesAutoresizingMaskIntoConstraints = false
         
         textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
         textField.textColor = .black
         textField.textAlignment = .left
         textField.placeholder = "type the title..."
         
         textField.attributedPlaceholder = NSAttributedString(
             string: "type the title...",
             attributes: [.foregroundColor: UIColor.systemGray]
         )
         
         return textField
     }()
     
     private(set) lazy var authorLabelIndicator: UILabel = labelIndicator(text: "Author")
     private(set) lazy var authorRect: UIView = rectIndicator()
     private(set) lazy var authorTextField: UITextField = {
         let textField = UITextField()
         textField.translatesAutoresizingMaskIntoConstraints = false
         
         textField.font = UIFont.systemFont(ofSize: 12, weight: .regular)
         textField.textColor = .black
         textField.textAlignment = .right
         textField.placeholder = "type the author..."
         
         textField.attributedPlaceholder = NSAttributedString(
             string: "type the title...",
             attributes: [.foregroundColor: UIColor.systemGray]
         )
         
         return textField
     }()
     
     
     private(set) lazy var reviewLabelIndicator: UILabel = labelIndicator(text: "Review")
     private(set) lazy var reviewRect: UIView = rectIndicator()
     private(set) lazy var reviewTextField: UITextField = {
         let textField = UITextField()
         textField.translatesAutoresizingMaskIntoConstraints = false
         
         textField.font = UIFont.systemFont(ofSize: 12, weight: .regular)
         textField.textColor = .black
         textField.textAlignment = .left
         textField.placeholder = "type the review..."
         
         textField.attributedPlaceholder = NSAttributedString(
             string: "type the title...",
             attributes: [.foregroundColor: UIColor.systemGray]
         )
         
         return textField
     }()
     
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
     
     //MARK: - Subiviews Funcs
     
     func labelIndicator(text: String) -> UILabel {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         
         label.text = text
         
         label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
         label.textColor = .sGray
         label.textAlignment = .left
         label.numberOfLines = 0
         
         return label
     }
     
     func rectIndicator() -> UIView {
         let view = UIView()
         view.translatesAutoresizingMaskIntoConstraints = false
         
         view.backgroundColor = .clear
         
         view.layer.borderWidth = 1.5
         view.layer.borderColor = UIColor.sGray.cgColor
         
         return view
     }
     
     
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
         
         addSubview(titleLabelIndicator)
         addSubview(titleRect)
         addSubview(titleTextField)
         
         addSubview(authorLabelIndicator)
         addSubview(authorRect)
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
             
             //TITLE
             titleLabelIndicator.topAnchor.constraint(equalTo: addCoverButton.bottomAnchor, constant: innerPadding),
             titleLabelIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
             titleLabelIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
             
             titleRect.topAnchor.constraint(equalTo: titleLabelIndicator.bottomAnchor, constant: 8),
             titleRect.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
             titleRect.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
             titleRect.heightAnchor.constraint(equalTo: titleTextField.heightAnchor, constant: 32),
             
             titleTextField.topAnchor.constraint(equalTo: titleLabelIndicator.bottomAnchor, constant: 20),
             titleTextField.leadingAnchor.constraint(equalTo: titleRect.leadingAnchor, constant: 12),
             titleTextField.trailingAnchor.constraint(equalTo: titleRect.trailingAnchor, constant: -12),
             
             
             
             //AUTHOR
             
             authorLabelIndicator.topAnchor.constraint(equalTo: titleRect.bottomAnchor, constant: innerPadding),
             authorLabelIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
             authorLabelIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
             
             authorRect.topAnchor.constraint(equalTo: authorLabelIndicator.bottomAnchor, constant: 8),
             authorRect.leadingAnchor.constraint(equalTo: leadingAnchor, constant: outterPadding),
             authorRect.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -outterPadding),
             authorRect.heightAnchor.constraint(equalTo: authorTextField.heightAnchor, constant: 32),
             
             authorTextField.topAnchor.constraint(equalTo: authorLabelIndicator.bottomAnchor, constant: 4),
             authorTextField.leadingAnchor.constraint(equalTo: authorRect.leadingAnchor, constant: outterPadding),
             authorTextField.trailingAnchor.constraint(equalTo: authorRect.trailingAnchor, constant: -outterPadding),
             
             //REVIEW
             reviewLabelIndicator.topAnchor.constraint(equalTo: authorRect.bottomAnchor, constant: innerPadding),
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

 
 
 */
