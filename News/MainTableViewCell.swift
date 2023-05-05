//
//  MainTableViewCell.swift
//  News
//
//  Created by Dima on 05.05.2023.
//

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

class MainTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "MainTableViewCell"
    
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "NewsTitleLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        label.text = "SubtitleLabel SubtitleLabel SubtitleLabel SubtitleLabel SubtitleLabel SubtitleLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(background)
        background.addSubview(newsTitleLabel)
        background.addSubview(subtitleLabel)
        background.addSubview(newsImageView)
        contentView.layer.cornerRadius = 10
        setupConstraints()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }


    
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
        
        // Image
        // Если в модели представления имеется загруженное изображение, установить его в newsImageView
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
            // Иначе, если есть URL изображения, выполнить запрос на его загрузку и установку
        } else if let url = viewModel.imageURL {
            // fetch
            // Создание запроса с использованием URLSession
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                // Если запрос выполнен успешно и вернул данные изображения
                guard let data = data, error == nil else { return }
                
                // Сохранение данных изображения в модель представления, чтобы не выполнять запрос повторно
                viewModel.imageData = data
                // Обновление изображения в UI на главном потоке
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
            background.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            background.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            background.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            background.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            newsImageView.topAnchor.constraint(equalTo: background.topAnchor, constant: 10),
            newsImageView.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -10),
            newsImageView.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10),
            newsImageView.widthAnchor.constraint(equalTo: heightAnchor),
            
            newsTitleLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 10),
            newsTitleLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            newsTitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -10),
            newsTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            subtitleLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 10),
            subtitleLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -10),
            subtitleLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -10)
        ])
    }
}
