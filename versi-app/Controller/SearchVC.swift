//
//  SearchVC.swift
//  versi-app
//
//  Created by 吳玹銘 on 2023/12/18.
//
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class SearchVC: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var serchField: RoundedBorderTextField!

    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()

    }

    func bind() {
        // Bind serchField
       let searchResultObservable = serchField.rx.text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .map {
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
            }
            .flatMap { query -> Observable<[Repo]> in
                if query == "" {
                    return Observable<[Repo]>.just([])
                } else {
                    let url = searchUrl + query + starsDescendingSegment
                    var searchRepos = [Repo]()

                    return URLSession.shared.rx.json(url: URL(string: url)!)
                        .map {
                            let results = $0 as AnyObject
                            let items = results.object(forKey: "items") as? [Dictionary<String, Any>] ?? []

                            for item in items {
                                guard let name = item["name"] as? String,
                                      let description = item["description"] as? String,
                                      let forksCount = item["forks_count"] as? Int,
                                      let repoUrl = item["html_url"] as? String else { break }
                                let language = item["language"] as? String ?? "Unknown"

                                let repo = Repo(image: UIImage(named: "searchIconLarge")!,
                                                name: name,
                                                description: description,
                                                numberOfForks: forksCount,
                                                language: language,
                                                numberOfContributors: 0,
                                                repoUrl: repoUrl)
                                searchRepos.append(repo)
                            }
                            return searchRepos
                        }
                }
            }
            .observe(on: MainScheduler.instance)

        searchResultObservable.bind(to: tableView.rx.items(cellIdentifier: "SearchCell", cellType: SearchCell.self)) {row, repo, cell in
            cell.config(repo: repo)
        }
        .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .subscribe { [unowned self] indexPath in
                guard let cell = self.tableView.cellForRow(at: indexPath) as? SearchCell else { return }
                let url = cell.repoUrl!
                self.presentSFSafariVCFor(url: url)
            }
            .disposed(by: disposeBag)
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
