//
//  SupportMeVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/21/23.
//

import UIKit
import StoreKit


class SupportMeVC: UIViewController {
    // table of donations options
    @IBOutlet weak var donationsView: UITableView!
    // donation option labels
    let cellLabels: [String] = ["💵 $0.99", "💸 $1.99", "💰 $4.99", "💳 $9.99", "💎 $19.99", "🧀 $49.99"]
    // store kit networking object
    let storeRepository: StoreRepositoryProtocol = StoreRepository()
    // transaction listener
    var updateListenerTask : Task<Void, Error>? = nil
    
    override func viewDidLoad(){
        super.viewDidLoad()
        donationsView.delegate = self
        donationsView.dataSource = self
        updateListenerTask = storeRepository.listenForTransactions()
        // initialize store for user
        Task {
            await storeRepository.requestProducts()
            await storeRepository.updateCustomerProductStatus()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateListenerTask?.cancel()
    }
}
