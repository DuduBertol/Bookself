//
//  BookList.swift
//  Books
//
//  Created by Eduardo Bertol on 01/10/25.
//

import Foundation
import UIKit

protocol BookListViewDelegate: AnyObject {
    func didTapAddButton()
}

class BookListView: UIView {
    
    weak var delegate: BookListViewDelegate?
    
    //MARK: - Subviews
    
    private(set) lazy var bookListCollectionView: UICollectionView = {
        let layout = makeThreeColumnSelfSizingLayout()
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    private(set) lazy var toolBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .sYellow
        
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.black.cgColor
        
        
        return view
    }()
    
    private(set) lazy var logotypeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: "Logotype")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    

    
    private(set) lazy var tagsHStack: UIView = {
        let button_1 = labelButton(width: 50, height: 25, text: "all", fontSize: 12)
        let button_2 = labelButton(width: 50, height: 25, text: "favs", fontSize: 12)
        let button_3 = labelButton(width: 50, height: 25, text: "now", fontSize: 12)
        let button_4 = labelButton(width: 50, height: 25, text: "done", fontSize: 12)
        let button_5 = labelButton(width: 50, height: 25, text: "want", fontSize: 12)
                
        let stackView = UIStackView(arrangedSubviews: [button_1, button_2, button_3, button_4, button_5])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
        
        
        stackView.isHidden = true //TODO: Tirar se eu implementar tags
        
        return stackView
    }()
    
    private(set) lazy var tabBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .sYellow
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.black.cgColor
        
        
        let button = sfSymbolButton(width: 40, height: 40, systemName: "plus", fontSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -4)
        ])
        
        return view
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
    
    func sfSymbolButton(width: CGFloat, height: CGFloat, systemName: String, fontSize: CGFloat) -> UIButton {
        let button = squareButton(width: width, height: height)
        
        let image = UIImage(systemName: systemName)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.setPreferredSymbolConfiguration(.init(pointSize: fontSize, weight: .regular), forImageIn: .normal)
        
        let action = UIAction { [weak self] _ in
            self?.delegate?.didTapAddButton()
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
    
//    func rect() -> UIView {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.backgroundColor = .sOrange
//        view.layer.borderWidth = 1.5
//        view.layer.borderColor = UIColor.black.cgColor
//        
//        NSLayoutConstraint.activate([
//            view.widthAnchor.constraint(equalToConstant: 50),
//            view.heightAnchor.constraint(equalToConstant: 25),
//        ])
//        
//        return view
//    }
    
    func makeThreeColumnSelfSizingLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 2
        
        // ITEM: largura = 1/3, altura estimada (vai se ajustar)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0/3.0),
            //            widthDimension: .estimated(110),
            heightDimension: .estimated(165) // tive que colocar meio hardcoded
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing/2, leading: spacing/2, bottom: spacing/2, trailing: spacing/2)
        
        // GROUP: horizontal com os 3 items lado a lado, altura estimada (irá ajustar)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(150)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupConstraints()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupCollectionView() {
        bookListCollectionView.register(
            BookListCell.self,
            forCellWithReuseIdentifier: "BookListCell"
        )
    }
    
    private func addSubviews() {
        addSubview(toolBar)
        addSubview(logotypeImage)
//        addSubview(tagsHStack)
        addSubview(bookListCollectionView)
        addSubview(tabBar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            toolBar.topAnchor.constraint(equalTo: topAnchor),
            toolBar.heightAnchor.constraint(equalToConstant: 130),
            toolBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            toolBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            logotypeImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logotypeImage.bottomAnchor.constraint(equalTo: toolBar.bottomAnchor, constant: -12),
            logotypeImage.heightAnchor.constraint(equalToConstant: 55),
            
            
            
//            tagsHStack.topAnchor.constraint(equalTo: toolBar.bottomAnchor),
//            tagsHStack.bottomAnchor.constraint(equalTo: bookListCollectionView.topAnchor),
//            tagsHStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 45),
//            tagsHStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            bookListCollectionView.topAnchor.constraint(equalTo: toolBar.bottomAnchor, constant: 0),
            bookListCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            bookListCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            bookListCollectionView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: 0),
            
            tabBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 85),
            tabBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
    }
    
    
}


//        let layout = UICollectionViewCompositionalLayout() {
//            sectionIndex,
//            environment in
//
//            //ITEM
//            let itemSize = NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .fractionalHeight(2.0)
//            )
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
//
//            //GROUP
//            let groupSize = NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .absolute(100)
//            )
//            let group = NSCollectionLayoutGroup.horizontal(
//                layoutSize: groupSize,
//                subitem: item,
//                count: 3
//            )
//
//            let section = NSCollectionLayoutSection(group: group)
//            return section
//        }

