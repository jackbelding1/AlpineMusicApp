//
//  SupportMeVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/21/23.
//

import UIKit
import StoreKit


class SupportMeViewController: UIViewController {
    
    @IBOutlet weak var supportMeBackButton: UIButton!
    
    // table of donations options
    @IBOutlet weak var donationOptions: UITableView!
    
    // donation option labels
    let donationOptionLabels: [String] = [
        "💵 $0.99", "💸 $1.99", "💰 $4.99", "💳 $9.99", "💎 $19.99",
        "🧀 $49.99"
    ]
    
    // store kit networking object
    let storeRepository: StoreRepositoryProtocol = StoreRepository()
    
    // transaction listener
    var updateListenerTask : Task<Void, Error>? = nil
    
    override func viewDidLoad(){
        super.viewDidLoad()
        donationOptions.delegate = self
        donationOptions.dataSource = self
        updateListenerTask = storeRepository.listenForTransactions()
        supportMeBackButton.accessibilityLabel = "supportMeBackButton"
        
        // initialize store for user
        Task {
            await storeRepository.requestProducts()
            await storeRepository.updateCustomerProductStatus()
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateListenerTask?.cancel()
    }
}
