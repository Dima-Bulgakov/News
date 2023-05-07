//
//  MainTableViewCell.swift
//  News
//
//  Created by Dima on 05.05.2023.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "MainTableViewCell"
    
    private let backgroundUnderImage: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(backgroundUnderImage)
        backgroundUnderImage.addSubview(newsTitleLabel)
        backgroundUnderImage.addSubview(subtitleLabel)
        backgroundUnderImage.addSubview(newsImageView)
        contentView.layer.cornerRadius = 10
        setupConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) { fatalError() }

    // MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    func setupContent(with viewModel: NewsTableViewCellViewModel) {
        newsTitleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}

// MARK: - Extension
private extension MainTableViewCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundUnderImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backgroundUnderImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            backgroundUnderImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            backgroundUnderImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            newsImageView.topAnchor.constraint(equalTo: backgroundUnderImage.topAnchor, constant: 15),
            newsImageView.bottomAnchor.constraint(equalTo: backgroundUnderImage.bottomAnchor, constant: -15),
            newsImageView.trailingAnchor.constraint(equalTo: backgroundUnderImage.trailingAnchor, constant: -15),
            newsImageView.widthAnchor.constraint(equalToConstant: 140),
            
            newsTitleLabel.topAnchor.constraint(equalTo: backgroundUnderImage.topAnchor, constant: 15),
            newsTitleLabel.leadingAnchor.constraint(equalTo: backgroundUnderImage.leadingAnchor, constant: 15),
            newsTitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -10),
            newsTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            subtitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 5),
            subtitleLabel.bottomAnchor.constraint(equalTo: backgroundUnderImage.bottomAnchor, constant: -15),
            subtitleLabel.leadingAnchor.constraint(equalTo: backgroundUnderImage.leadingAnchor, constant: 15),
            subtitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -10)
        ])
    }
}
