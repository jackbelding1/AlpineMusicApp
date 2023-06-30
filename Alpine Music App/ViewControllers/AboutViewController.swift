//
//  AboutVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit

class AboutVC: UIViewController {
    // image for about me screen
    @IBOutlet weak var imageView: UIImageView!
    // table of social media links
    @IBOutlet weak var socialTableView: UITableView!
    // social media objects to be displayed
    @Published var socials:[Social] = [Social]()
    private let socialsRepository: SocialsRepositoryProtocol = SocialsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socialTableView.accessibilityIdentifier = "socialTable"
        fetchSocials()
        socialTableView.delegate = self
        socialTableView.dataSource = self
    }

    // fetch social media objects from firebase
    func fetchSocials() {
        Task {
            do {
                socials = try await socialsRepository.fetchSocials()
                socialTableView.reloadData()
            } catch {
                print("Cannoth fetch socials: \(error)")
            }
        }
    }

}
