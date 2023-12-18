//
//  TrendingCell.swift
//  versi-app
//
//  Created by 吳玹銘 on 2023/12/18.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingCell: UITableViewCell {

    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDiscriptionLabel: UILabel!
    @IBOutlet weak var numberOfForksLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var contributorsLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var viewReadmeButton: RoundedBorderButton!

    private var repoUrl: String?
    var disposeBag = DisposeBag()

    func config(repo: Repo) {

        repoImageView.image = repo.image
        repoNameLabel.text = repo.name
        repoDiscriptionLabel.text = repo.description
        numberOfForksLabel.text = String(describing: repo.numberOfForks)
        languageLabel.text = repo.language
        contributorsLabel.text = String(describing: repo.numberOfContributors)
        repoUrl = repo.repoUrl

        viewReadmeButton.rx.tap
            .subscribe(onNext: {
                self.window?.rootViewController?.presentSFSafariVCFor(url: self.repoUrl!)
            })
            .disposed(by: disposeBag)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backView.layer.cornerRadius = 15
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 0.25
        backView.layer.shadowRadius = 5.0
        backView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
