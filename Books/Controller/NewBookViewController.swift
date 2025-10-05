//
//  NewBookViewController.swift
//  Books
//
//  Created by Eduardo Bertol on 02/10/25.
//

import Foundation
import UIKit
import PhotosUI

class NewBookViewController: UIViewController {
    
    // MARK: - Properties
    private let newBookView: NewBookView
    
    private let bookRepository = BookRepository()
    
    private var selectedCoverImage: UIImage?
    
    
    
    //MARK: - Initializers
    init(book: Book? = nil) {
        newBookView = NewBookView(book: book)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("use init(user:)")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = newBookView
        
        newBookView.delegate = self
    
        
        view.backgroundColor = .sBege
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //      navigationItem.title = user.name
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //      userView.goBatshitCrazy()
        
    }
    
    // MARK: - Setup Methods
    
    func showSimpleMessageAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
}



//MARK: - ============== -



//MARK: - NewBookViewDelegate
extension NewBookViewController: NewBookViewDelegate {
    //Create
    func didTapAddCover() {
        presentPhotoPicker()
    }
    
    //Update 
    func didTapOptionsButton() {
        print("Option Button")
    }
    
    func didTapEditButton() {
        print("Edit Button")
    }
    
    //Delete
    func didTapDeleteButton() {
        print("Delete Button")
    }
    
    //Save
    func didTapDoneButton() {
        
        let title = newBookView.titleTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let title = title, !title.isEmpty else {
            showSimpleMessageAlert(title: "Ops", message: "Digite o título do livro.")
            return
        }
        
        let author = newBookView.authorTextField.text ?? "No Author"
        let review = newBookView.reviewTextField.text ?? "Empty review."
        //rating
        
        let tempBook = Book(
            id: UUID(),
            title: title,
            author: author,
            review: review,
            rating: 0,
            cover: selectedCoverImage,
            createdAt: Date()
        )
        
        //no repo: UIImage -> Data
        bookRepository.create(from: tempBook)
        
        showSimpleMessageAlert(title: "Sucesso.", message: "Livro incluído com sucesso!")
    }
}



// MARK: - PHPicker + load image usando UIGraphicsImageRenderer

extension NewBookViewController: PHPickerViewControllerDelegate {
    
    func presentPhotoPicker(){
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        
        itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
            guard let self = self else { return }
            
            if let image = object as? UIImage {
                let resized = self.resizeImageIfNeeded(image: image, maxDimension: 1200)
                DispatchQueue.main.async{
                    self.selectedCoverImage = resized
                    self.newBookView.coverButton.setImage(resized, for: .normal)
                }
            } else if let error = error {
                DispatchQueue.main.async{
                    self.showSimpleMessageAlert(title: "Erro", message: error.localizedDescription)
                }
            }
        }
        
        return
              
        // fallback: se não puder loadObject(ofClass:), tenta dataRepresentation
//        if let identifier = results.first?.assetIdentifier {
//  //           Caso queira obter via PHAsset (mais trabalho) — omitido por agora
//            return
//        }
    }
    
    private func resizeImageIfNeeded(image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        let maxSide = max(image.size.width, image.size.height)
        guard maxSide > maxDimension else { return image }
        
        let scale = maxDimension / maxSide
        let newSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = UIScreen.main.scale
        format.opaque = true
        
        let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
        let renderedImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        return renderedImage
    }
}
