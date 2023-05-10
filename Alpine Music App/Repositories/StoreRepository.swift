//
//  StoreRepository.swift
//  Alpine Music App
//
//  Created by Jack Belding on 5/1/23.
//

import Foundation
import StoreKit

typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState


protocol StoreRepositoryProtocol {
    func listenForTransactions() -> Task<Void, Error>
    func requestProducts() async
    func updateCustomerProductStatus() async
    func donate(option donationOption:Int)
}

class StoreRepository: StoreRepositoryProtocol {
    // donations specified in product file
    @Published private(set) var donations: [Product] = []
    // purchased auto renewable subscriptions (deprecated)
    @Published private(set) var purchasedSubscriptions: [Product] = []
    // the ids specified in the product file
    private let productIds: [String] = ["tier.0", "tier.1", "tier.2", "tier.3", "tier.4", "tier.5"]

    // handle user select donation cell
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
 
    // verify for transactions
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
    
    // check for verification
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
    
    // check for auto renewable subscriptions (deprecated)
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

// store kit errors
public enum StoreError: Error {
    case failedVerification
}
