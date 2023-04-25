//
//  SupportMeVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/21/23.
//

import UIKit
import StoreKit

typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState

class SupportMeVC: UIViewController {
    @Published private(set) var donations: [Product] = []
    @Published private(set) var purchasedSubscriptions: [Product] = []
    @Published private(set) var subscriptionGroupStatus: RenewalState?
    
    @IBOutlet weak var donationsView: UITableView!
        
    let cellLabels: [String] = ["💵 $0.99", "💸 $1.99", "💰 $4.99", "💳 $9.99", "💎 $19.99", "🧀 $49.99"]
    private let productIds: [String] = ["tier.0", "tier.1", "tier.2", "tier.3", "tier.4", "tier.5"]
    
    var updateListenerTask : Task<Void, Error>? = nil
    
    override func viewDidLoad(){
        super.viewDidLoad()
        donationsView.delegate = self
        donationsView.dataSource = self
        updateListenerTask = listenForTransactions()
        
        Task {
            await requestProducts()
            
            await updateCustomerProductStatus()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateListenerTask?.cancel()
    }
    
    func donate(option donationOption:Int) {
        Task {
            let product = donations[donationOption]
            do {
                if try await purchase(product) != nil {
                    print("purchase successful")
                }
            } catch {
                print("purchase failed")
            }
        }
    }
    
//    @objc func buttonAction(button: UIButton) {
//        Task {
//            let product = subscriptions[0]
//            do {
//                if try await purchase(product) != nil {
//                    isPurchased = true
//                }
//            } catch {
//                print("purchase failed")
//            }
//        }
//    }
//
//    func createButton() {
//        let button = UIButton(type: .system)
//        button.frame = CGRect(x: 100, y: 100, width: 100, height: 90)
//        button.backgroundColor = .green
//        button.setTitle("Press me", for: .normal)
//
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//
//        button.isEnabled = !isPurchased
//
//        self.view.addSubview(button)
//    }
 
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            //Iterate through any transactions that don't come from a direct call to `purchase()`.
            for await result in Transaction.updates {
                do {
                    let transaction = try await self.checkVerified(result)
                    // deliver products to the user
                    await self.updateCustomerProductStatus()
                    
                    await transaction.finish()
                } catch {
                    print("transaction failed verification")
                }
            }
        }
    }
    
    
    
    // Request the products
    @MainActor
    func requestProducts() async {
        do {
            // request from the app store using the product ids (hardcoded)
            donations = try await Product.products(for: productIds)
            print(donations)
        } catch {
            print("Failed product request from app store server: \(error)")
        }
    }
    
    // purchase the product
    @MainActor
    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        
        switch result {
        case .success(let verification):
            //Check whether the transaction is verified. If it isn't,
            //this function rethrows the verification error.
            let transaction = try checkVerified(verification)
            
            //The transaction is verified. Deliver content to the user.
            await updateCustomerProductStatus()
            
            //Always finish a transaction.
            await transaction.finish()

            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        //Check whether the JWS passes StoreKit verification.
        switch result {
        case .unverified:
            //StoreKit parses the JWS, but it fails verification.
            throw StoreError.failedVerification
        case .verified(let safe):
            //The result is verified. Return the unwrapped value.
            return safe
        }
    }
    
    @MainActor
    func updateCustomerProductStatus() async {
        for await result in Transaction.currentEntitlements {
            do {
                //Check whether the transaction is verified. If it isn’t, catch `failedVerification` error.
                let transaction = try checkVerified(result)
                
                switch transaction.productType {
                    case .autoRenewable:
                        if let subscription = donations.first(where: {$0.id == transaction.productID}) {
                            purchasedSubscriptions.append(subscription)
                        }
                    default:
                        break
                }
                //Always finish a transaction.
                await transaction.finish()
            } catch {
                print("failed updating products")
            }
        }
    }

}

public enum StoreError: Error {
    case failedVerification
}
