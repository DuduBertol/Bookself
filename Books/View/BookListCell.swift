//
//  BookListCell.swift
//  Books
//
//  Created by Eduardo Bertol on 01/10/25.
//

import UIKit

class BookListCell: UICollectionViewCell {

    static let reuseIdentifier = "BookListCell"

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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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

    // Agora aceita BookEntity (Core Data)
    func configure(with entity: BookEntity) {
        // Se você armazenou a imagem em `cover` (Data)
        if let data = entity.cover, let img = UIImage(data: data) {
            bookImage.image = img
            return
        }

        // Fallback: se você ainda usa imageName na struct, tenta usar title/author para escolher placeholder
        // Aqui usamos o placeholder bundle image como padrão
        bookImage.image = UIImage(named: "placeholder")
    }

    private func addSubViews() {
        contentView.addSubview(borderRect)
        contentView.addSubview(bookImage)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bookImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bookImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            bookImage.widthAnchor.constraint(equalToConstant: 100),
            bookImage.heightAnchor.constraint(equalToConstant: 150),

            borderRect.centerXAnchor.constraint(equalTo: bookImage.centerXAnchor),
            borderRect.centerYAnchor.constraint(equalTo: bookImage.centerYAnchor),
            borderRect.widthAnchor.constraint(equalTo: bookImage.widthAnchor, constant: 8),
            borderRect.heightAnchor.constraint(equalTo: bookImage.heightAnchor, constant: 8),
        ])
    }
}
