//
//  NewBookViewController.swift
//  Books
//
//  Created by Eduardo Bertol on 02/10/25.
//

import Foundation
import UIKit

class NewBookViewController: UIViewController {
    
    // MARK: - Properties
    private let newBookView: NewBookView
    
    init() {
        newBookView = NewBookView()
        
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
}
