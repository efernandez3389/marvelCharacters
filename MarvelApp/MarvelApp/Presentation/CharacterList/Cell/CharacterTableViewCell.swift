//
//  CharacterTableViewCell.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import UIKit
import SDWebImage

class CharacterTableViewCell: UITableViewCell {

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: Constants.FontSize.medium)
        label.numberOfLines = 0
        return label
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViewHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withViewModel viewModel: CharacterTableViewCellViewModel) {
        characterNameLabel.text = viewModel.name
        characterImageView.sd_setImage(with: viewModel.imageURL)
    }
    
    func configureViewHierarchy() {
        // Configure character imageview
        addSubview(characterImageView)
        addSubview(characterNameLabel)

        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Spacing.none),
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Spacing.none),
            characterImageView.widthAnchor.constraint(equalToConstant: Constants.Size.width),
            characterImageView.heightAnchor.constraint(equalToConstant: Constants.Size.height)
        ])
        
        NSLayoutConstraint.activate([
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: Constants.Spacing.medium),
            characterNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Spacing.medium),
            characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.Spacing.medium),
            characterNameLabel.heightAnchor.constraint(equalToConstant: Constants.Size.height
                                                      )
        ])
    }
}
