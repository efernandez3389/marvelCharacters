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
        label.textColor = .blue
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
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            characterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            characterImageView.widthAnchor.constraint(equalToConstant: 175),
            characterImageView.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        NSLayoutConstraint.activate([
            characterNameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 0),
            characterNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            characterNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
}
