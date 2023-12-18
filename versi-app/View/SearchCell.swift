//
//  SearchCell.swift
//  versi-app
//
//  Created by 吳玹銘 on 2023/12/18.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDesLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!

    public private(set) var repoUrl: String?

    func config(repo: Repo) {
        repoNameLabel.text = repo.name
        repoDesLabel.text = repo.description
        forksLabel.text = String(describing: repo.numberOfForks)
        languageLabel.text = repo.language
        repoUrl = repo.repoUrl

    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = 15

    }


}
