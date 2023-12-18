
import UIKit
import RxSwift
import RxCocoa

class TrendingFeedVC: UIViewController {

    @IBOutlet weak var tabelView: UITableView!

    let refreshControl = UIRefreshControl()

    var dataSource = PublishSubject<[Repo]>()
    var disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
        bindingModel()

    }

    @objc
    func fetchData() {
        DownloadService.shared.downloadTrendingRepos { reposArray in
            self.dataSource.onNext(reposArray)
            self.refreshControl.endRefreshing()
        }
    }

    func setupTableView() {
        tabelView.refreshControl = refreshControl
        refreshControl.tintColor = UIColor(named: "Color")
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Hot Github Repos🔥", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Color")!,
            NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!])
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
    }

    func bindingModel() {
        dataSource.bind(to: tabelView.rx.items(cellIdentifier: "TrendingCell", cellType: TrendingCell.self)) { row, repo, cell in

            cell.config(repo: repo)

        }
        .disposed(by: disposeBag)
    }
}

