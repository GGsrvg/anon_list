//
//  AnonTableViewCell.swift
//  list
//
//  Created by GGsrvg on 03.05.2020.
//  Copyright © 2020 GGsrvg. All rights reserved.
//

import UIKit

class AnonTableViewCell: UITableViewCell {
    
    private let imageViewContent = UIImageView()
    
    private let additionalStack = UIStackView()
    
    private let userNameLabel = createLabel(text: "", fontSize: 18, weight: .semibold)
    
    private let textContentLabel = createLabel(text: "", fontSize: 14, weight: .light)
    
    private let likesLabel = createLabel(text: "0", fontSize: 12, weight: .bold)
    
    private let viewsLabel = createLabel(text: "0", fontSize: 12, weight: .bold)
    
    private let commentsLabel = createLabel(text: "0", fontSize: 12, weight: .bold)
    
    private let shareLabel = createLabel(text: "0", fontSize: 12, weight: .bold)
    
    
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
        
        additionalStack.spacing = 12
        additionalStack.axis = .horizontal
        
        additionalStack.addArrangedSubview(likesLabel)
        additionalStack.addArrangedSubview(viewsLabel)
        additionalStack.addArrangedSubview(commentsLabel)
        additionalStack.addArrangedSubview(shareLabel)
        additionalStack.addArrangedSubview(UIView())
        
        imageViewContent.contentMode = .scaleAspectFill
        imageViewContent.layer.masksToBounds = true
        imageViewContent.widthAnchor.constraint(equalTo: imageViewContent.heightAnchor, multiplier: 4.0/3.0).isActive = true
        
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 10
        
        mainStack.addArrangedSubview(userNameLabel)
        textContentLabel.numberOfLines = 6
        mainStack.addArrangedSubview(textContentLabel)
        mainStack.addArrangedSubview(imageViewContent)
        mainStack.addArrangedSubview(additionalStack)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(mainStack)
        
        NSLayoutConstraint.init(item: mainStack, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint.init(item: contentView, attribute: .bottom, relatedBy: .equal, toItem: mainStack, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint.init(item: mainStack, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 12).isActive = true
        NSLayoutConstraint.init(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: mainStack, attribute: .trailing, multiplier: 1, constant: 12).isActive = true
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
