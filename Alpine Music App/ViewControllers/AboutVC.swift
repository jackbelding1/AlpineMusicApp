//
//  AboutVC.swift
//  Alpine Music App
//
//  Created by Jack Belding on 4/13/23.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var socialTableView: UITableView!
    @Published var socials:[Social] = [Social]()
    private let socialsRepository: SocialsRepositoryProtocol = SocialsRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSocials()
        socialTableView.delegate = self
        socialTableView.dataSource = self
        imageView.image = UIImage(named: "logo.jpg")
    }

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
