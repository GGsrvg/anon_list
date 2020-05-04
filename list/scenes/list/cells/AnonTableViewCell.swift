//
//  AnonTableViewCell.swift
//  list
//
//  Created by GGsrvg on 03.05.2020.
//  Copyright © 2020 GGsrvg. All rights reserved.
//

import UIKit

class AnonTableViewCell: UITableViewCell {
    
    // MARK: UI Items
    private let imageViewContent: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 4.0/3.0).isActive = true
        return imageView
    }()

    private let additionalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private let userNameLabel: UILabel = {
        let label = createLabel(text: "", fontSize: 18, weight: .semibold)
        return label
    }()
    
    private let textContentLabel: UILabel = {
        let label = createLabel(text: "", fontSize: 14, weight: .light)
        label.numberOfLines = 6
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = createLabel(text: "0", fontSize: 12, weight: .bold)
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = createLabel(text: "0", fontSize: 12, weight: .bold)
        return label
    }()
    
    private let commentsLabel: UILabel = {
        let label = createLabel(text: "0", fontSize: 12, weight: .bold)
        return label
    }()
    
    private let shareLabel: UILabel = {
        let label = createLabel(text: "0", fontSize: 12, weight: .bold)
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        /*
            VStack
                UserNameLabel
                TextLabel
                ImageLabel
                HStack
                    ItemHStack(likeImage, LikeCount)
                    ItemHStack(viewsImage, ViewsCount)
                    ItemHStack(commentsImage, CommentsCount)
                    ItemHStack(shareImage, ShareCount)
         */
        
        additionalStack.addArrangedSubview(likesLabel)
        additionalStack.addArrangedSubview(viewsLabel)
        additionalStack.addArrangedSubview(commentsLabel)
        additionalStack.addArrangedSubview(shareLabel)
        additionalStack.addArrangedSubview(UIView())
        
        mainStack.addArrangedSubview(userNameLabel)
        mainStack.addArrangedSubview(textContentLabel)
        mainStack.addArrangedSubview(imageViewContent)
        mainStack.addArrangedSubview(additionalStack)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        
        self.mainStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12).isActive = true
        self.mainStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        self.mainStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12).isActive = true
        self.mainStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: Set Data
    func setData(userName: String?, textContent: String?, imageContent: UIImage?, likeCount: Int, viewsCount: Int, commentsCount: Int, shareCount: Int){
        if let userName = userName {
            self.userNameLabel.text = userName
        } else {
            self.userNameLabel.isHidden = true
        }
        
        if let textContent = textContent {
            self.textContentLabel.text = textContent
        } else {
            self.textContentLabel.isHidden = true
        }
        
        if let imageContent = imageContent {
            self.imageViewContent.image = imageContent
        } else {
            self.imageViewContent.isHidden = true
        }
        
        self.likesLabel.text = String(likeCount)
        self.viewsLabel.text = String(viewsCount)
        self.commentsLabel.text = String(commentsCount)
        self.shareLabel.text = String(shareCount)
    }
    
    func haveImage() -> Bool {
        return self.imageViewContent.image != nil
    }
}
