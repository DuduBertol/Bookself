//
//  CustomRect.swift
//  Books
//
//  Created by Eduardo Bertol on 05/10/25.
//


import Foundation
import UIKit
class CustomRect: UIView {
    
    //MARK: - Subviews
    
    
    //MARK: - Initializers
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.black.cgColor
        
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
