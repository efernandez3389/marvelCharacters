//
//  CharacterTableViewCell.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 6/4/22.
//

import UIKit
import SDWebImage
import SnapKit

class CharacterTableViewCell: UITableViewCell {
    static let identifier = "CharacterTableViewCell"
    
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

        characterImageView.snp.makeConstraints { (make) -> Void in
            make.leading.top.equalToSuperview()
            make.width.equalTo(Constants.Size.width)
            make.height.equalTo(Constants.Size.height)
        }
        
        characterNameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(characterImageView.snp.trailing).offset(Constants.Spacing.medium)
            make.top.equalToSuperview().offset(Constants.Spacing.medium)
            make.trailing.equalToSuperview().offset(-Constants.Spacing.medium)
            make.height.equalTo(Constants.Size.height)
        }
    }
}
