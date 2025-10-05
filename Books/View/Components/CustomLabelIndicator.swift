//
//  CustomLabelIndicator.swift
//  Books
//
//  Created by Eduardo Bertol on 05/10/25.
//


import Foundation
import UIKit
class CustomLabelIndicator: UILabel {
    
    //MARK: - Subviews
    
    
    //MARK: - Initializers
    init(fontSize: CGFloat, text: String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.text = text
        
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        textColor = .black
        textAlignment = .left
        numberOfLines = 0
        
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
