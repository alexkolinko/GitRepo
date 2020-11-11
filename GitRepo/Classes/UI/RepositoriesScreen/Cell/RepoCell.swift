//
//  RepoCell.swift
//  GitRepo
//
//  Created by Admin on 10.11.2020.
//


import UIKit

class RepoCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageRepo: UIImageView!
    @IBOutlet weak var starsCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(repository: Repository) {
        let stars = String(repository.stargazers_count)
        name.text = repository.name
        starsCount.text = stars
        imageRepo.loadImageBy(repository.owner?.avatar_url)
    }
    
}

extension RepoCell {
    static func register(to tableView: UITableView) {
        let cellString = String(describing: self)
        let cellNib = UINib(nibName: cellString, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellString)
    }
}
