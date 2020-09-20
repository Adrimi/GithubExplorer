//
//  UserDetailsViewController.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 20/09/2020.
//

import UIKit
import Combine

class UserDetailsViewController: UIViewController {
    
    private var cancellables = Set<AnyCancellable>()
    private var uiCancellables = Set<AnyCancellable>()
    
    private let stackView: UIStackView = {
        let s = UIStackView()
        s.untranslate()
        s.axis = .vertical
        s.spacing = UIStackView.spacingUseSystem
        s.isLayoutMarginsRelativeArrangement = true
        s.directionalLayoutMargins = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        return s
    }()
    
    private let userImageView = UIImageView()
    
    private let userNameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 24, weight: .bold)
        return l
    }()
    
    convenience init(_ vm: SuggestionViewModel) {
        self.init()
        userNameLabel.text = vm.text
        downloadImage(imageView: userImageView, urlString: vm.imageURL)
        setupConstraints()
        populateStackView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: guide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor)
        ])
    }
    
    private func populateStackView() {
        [userImageView, userNameLabel]
            .forEach { stackView.addArrangedSubview($0) }
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
