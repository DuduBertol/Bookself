//
//  BookListViewController.swift
//  Books
//
//  Created by Eduardo Bertol on 01/10/25.
//

import UIKit
import CoreData

class BookListViewController: UIViewController {

    //MARK: - Properties
    
    private let bookListView = BookListView()

    ///Esse cara possui a fonte de verdade "dinâmica" - o fetch que puxa os BookEntity/Book
    // FRC que monitora BookEntity
    lazy var fetchedResultsController: NSFetchedResultsController<BookEntity> = {
        let req: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: req,
                                             managedObjectContext: CoreDataStack.shared.viewContext,
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        return frc
    }()

    private var books: [BookEntity]? { fetchedResultsController.fetchedObjects } //nao sei se isso vai funcionar, mas eu suponho ser uma referência na HEAP
    

    // Diffable data source usando NSManagedObjectID
    private var dataSource: UICollectionViewDiffableDataSource<Int, NSManagedObjectID>!
    
    
    //MARK: - Initializers
    override func loadView() {
        super.loadView()
        super.view = bookListView
        view.backgroundColor = .sBege
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bookListView.delegate = self

        // configure collection view delegate & data source (diffable)
        bookListView.bookListCollectionView.delegate = self
        configureDataSource()
        try? fetchedResultsController.performFetch() ///efetivamente realiza o fetch
        applySnapshot(animatingDifferences: true)
        
        print("FRC count:", fetchedResultsController.fetchedObjects?.count ?? 0)
        print("Snapshot IDs:", dataSource.snapshot().itemIdentifiers)
    }

    // MARK: - Data source setup
    ///O coração da célula
    private func configureDataSource() {
        // cell provider: fetch BookEntity by objectID and configure cell
        dataSource = UICollectionViewDiffableDataSource<Int, NSManagedObjectID>(
            collectionView: bookListView.bookListCollectionView,
            cellProvider: { collectionView, indexPath, objectID in ///Cell recebe um item (objectID)
                guard let entity = try? CoreDataStack.shared.viewContext.existingObject(with: objectID) as? BookEntity else { return nil } ///recupera a entity correspondente
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookListCell", for: indexPath) as? BookListCell else {
                    return nil
                }
                cell.configure(with: entity) ///popula a cell com a entity
                return cell
            }
        )
    }
    
    ///Onde o array é criado
    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, NSManagedObjectID>()
        snapshot.appendSections([0]) ///seção main
        ///Aqui a lista se materializa como array
        let items = fetchedResultsController.fetchedObjects?.map { $0.objectID } ?? []
        snapshot.appendItems(items) ///att da UI
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences) ///
        
        ///"fetchedResultsController.fetchedObjects" é o ARRAY DE LIVROS
        ///ITEMS é o "array de livros" pós map
    }

    // MARK: - Actions
    func didTapPlusButton() {
        // caso queira usar um fluxo customizado ao tocar + programaticamente
        let newBookVC = NewBookViewController()
        present(newBookVC, animated: true)
    }
}

// MARK: - Collection view delegate (selection, layout)
extension BookListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 48
        return CGSize(width: width, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // obter objectID via snapshot + pedir o objeto
        ///pega o NSManagedObjectID que está na cell
        guard let itemID = dataSource.itemIdentifier(for: indexPath) else { return }

        ///o ID vira Entity
        guard let entity = try? CoreDataStack.shared.viewContext.existingObject(with: itemID) as? BookEntity else { return }

        ///a Entity vira Struct
        let bookStruct = entity.toStruct()
        
        let bookVC = BookViewController(book: bookStruct)
        present(bookVC, animated: true)

//        if let toStruct = (entity as BookEntity).toStruct as (() -> Book)? {
//            let bookStruct = entity.toStruct()
//            let bookVC = BookViewController(book: bookStruct)
//            present(bookVC, animated: true)
//            return
//        }

        // Caso seu BookViewController aceite BookEntity diretamente, adapte aqui:
        // let bookVC = BookViewController(bookEntity: entity)
        // present(bookVC, animated: true)
    }
}

// MARK: - BookListViewDelegate
extension BookListViewController: BookListViewDelegate {
    func didTapAddButton() {
        let newBookVC = NewBookViewController()
        present(newBookVC, animated: true)
    }
}

// MARK: - FRC delegate
extension BookListViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        // reaplica snapshot simples; para mudanças grandes você pode diffar manualmente
        /// tipo um published nesse caso? reativo as mudanças...
        applySnapshot()
    }
}



///COMO LER OS LIVROS?
/*
 Array 1 — o array real do Core Data:
    fetchedResultsController.fetchedObjects → [BookEntity]?
    Pode inspecionar/usar esse array diretamente (ex.: let livro = fetchedResultsController.fetchedObjects?[indexPath.row]), contanto que a ordenação e seções batam com o snapshot.

 Array 2 — o array do snapshot (IDs):
    let snapshot = dataSource.snapshot() → snapshot.itemIdentifiers retorna [NSManagedObjectID].
    Para pegar o objeto em um indexPath: let id = dataSource.itemIdentifier(for: indexPath).

 Para contar itens:
    fetchedResultsController.fetchedObjects?.count ou
    dataSource.snapshot().itemIdentifiers.count.

 Para debug rápido no console:
    print("FRC count:", fetchedResultsController.fetchedObjects?.count ?? 0)
    print("Snapshot IDs:", dataSource.snapshot().itemIdentifiers)
 */
