//
//  TextFieldTableViewCell.swift
//  GithubExplorer
//
//  Created by adrian.szymanowski on 19/09/2020.
//

import UIKit
import Combine

class TextFieldTableViewCell: UITableViewCell {
    
    private lazy var textField: UITextField = {
        let f = UITextField()
        f.inputAccessoryView = nil
        f.borderStyle = .roundedRect
        f.untranslate()
        return f
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    convenience init(_ viewModel: FieldViewModel) {
        self.init()
        
        setupConstraints()
        
        let textFieldPublisher = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification)
            .map { $0.object as! UITextField }
            .map(\.text)
        
        
        textFieldPublisher
            .removeDuplicates()
            .throttle(for: 3.0, scheduler: RunLoop.main, latest: true)
            .sink(receiveValue: { text in
                viewModel.text.send(text!)
            })
            .store(in: &cancellables)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        textField.resignFirstResponder()
        cancellables = Set<AnyCancellable>()
    }
    
    private func setupConstraints(includeMargins: Bool = true) {
        let guide = includeMargins ? contentView.layoutMarginsGuide : contentView.safeAreaLayoutGuide
        
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: guide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            guide.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            guide.bottomAnchor.constraint(equalTo: textField.bottomAnchor)
        ])
    }
}
