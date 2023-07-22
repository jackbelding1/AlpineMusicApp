//
//  AboutVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit

class AboutViewController: UIViewController {
    // image for about me screen
    @IBOutlet weak var aboutMeImage: UIImageView!
    
    // table of social media links
    @IBOutlet weak var socialsTable: UITableView!
    
    // social media objects to be displayed
    @Published var socials:[Social] = [Social]()
    
    // Repository for fetching social media objects
    private let socialsRepository: SocialsRepositoryProtocol = SocialsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socialsTable.accessibilityIdentifier = "socialTable"
        fetchSocials()
        socialsTable.delegate = self
        socialsTable.dataSource = self
    }

    // fetch social media objects from firebase
    func fetchSocials() {
        Task {
            do {
                socials = try await socialsRepository.fetchSocials()
                socialsTable.reloadData()
            } catch {
                print("Cannot fetch socials: \(error)")
            }
        }
    }
}
