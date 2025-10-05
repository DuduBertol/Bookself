//
//  CustomTextField.swift
//  Books
//
//  Created by Eduardo Bertol on 05/10/25.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    //MARK: - Subviews
    
    
    //MARK: - Initializers
    init(fontSize: CGFloat, placeholderText: String?) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        textColor = .black
        textAlignment = .left
        placeholder = placeholderText
        autocorrectionType = .no
        
        attributedPlaceholder = NSAttributedString(
            string: placeholderText ?? "",
            attributes: [.foregroundColor: UIColor.sBegeOpaque]
        )
        
        addSubViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup Methods
    
    private func addSubViews() {
        
    }
    
    private func setupConstraints() {
        
    }
    
    
    }
