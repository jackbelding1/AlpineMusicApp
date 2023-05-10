//
//  SupportMeVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/21/23.
//

import UIKit
import StoreKit


class SupportMeVC: UIViewController {
    @IBOutlet weak var donationsView: UITableView!
        
    let cellLabels: [String] = ["💵 $0.99", "💸 $1.99", "💰 $4.99", "💳 $9.99", "💎 $19.99", "🧀 $49.99"]
    
    let storeRepository: StoreRepositoryProtocol = StoreRepository()
    var updateListenerTask : Task<Void, Error>? = nil
    
    override func viewDidLoad(){
        super.viewDidLoad()
        donationsView.delegate = self
        donationsView.dataSource = self
        updateListenerTask = storeRepository.listenForTransactions()
        
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
