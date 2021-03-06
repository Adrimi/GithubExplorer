//
//  HomeViewController.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 17/09/2020.
//

import UIKit
import Combine

enum CellViewModel: Hashable {
    case field(FieldViewModel)
    case suggestion(SuggestionViewModel)
}

class HomeViewController: UITableViewController {
    
    typealias Section = String
    typealias Row = CellViewModel
    typealias DataSource = UITableViewDiffableDataSource<Section, Row>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    private var viewModel: HomeViewModel?
    private var cancellables = Set<AnyCancellable>()
    private var uiCancellables = Set<AnyCancellable>()
    private var latestSnapshot: Snapshot?
    
    convenience init(viewModel: HomeViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search for Github User"
        
        tableView.dataSource = nil
        tableView.register(UITableViewCell.self)
        tableView.register(TextFieldTableViewCell.self)
        tableView.tableFooterView = UIView()
        
        let datasource = DataSource(tableView: tableView) { tableView, _, row -> UITableViewCell? in
            switch row {
            case let .field(vm):
                return TextFieldTableViewCell(vm)
            case let .suggestion(suggestion):
                let cell = UITableViewCell(style: .default, reuseIdentifier: UITableViewCell.reuseID)
                cell.textLabel?.text = suggestion.text
                self.downloadImage(imageView: cell.imageView,
                                   urlString: suggestion.imageURL)
                return cell
            }
        }
        
        viewModel?.state
            .map { state -> (section: Section, rows: [Row]) in
                switch state {
                case let .field(field):
                    return ("Search Section", [.field(field)])
                case let .fieldWithSuggestions(field, suggestions):
                    return ("Search Section", [.field(field)] + suggestions
                                .map(CellViewModel.suggestion)
                    )
                }
            }
            .map { tuple -> Snapshot in
                var s = Snapshot()
                s.appendSections([tuple.section])
                s.appendItems(tuple.rows)
                return s
            }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] snapshot in
                self?.tableView.dataSource = datasource
                datasource.apply(snapshot, animatingDifferences: true)
                self?.latestSnapshot = snapshot
            })
            .store(in: &cancellables)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row > 0 else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        view.endEditing(true)
        
        let item = latestSnapshot?.itemIdentifiers(inSection: "Search Section")[indexPath.row]
        if case let .suggestion(vm) = item {
            show(UserDetailsViewController(vm), sender: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func downloadImage(imageView: UIImageView?, urlString: String) {
        guard let url = URL(string: urlString),
              let imageView = imageView else { return }
        URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .map(\.data)
            .map(UIImage.init)
            .catch { _ in
                Just(nil)
            }
            .sink { imageView.image = $0 }
            .store(in: &uiCancellables)
            
    }
}
