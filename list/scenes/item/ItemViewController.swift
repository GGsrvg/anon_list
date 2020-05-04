//
//  ItemViewController.swift
//  list
//
//  Created by GGsrvg on 03.05.2020.
//  Copyright © 2020 GGsrvg. All rights reserved.
//

import UIKit
import DataManager

class ItemViewController: UIViewController {

    private let item: Item
    
    // MARK: UI Items
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 14
        return stack
    }()
    private let additionalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        return stack
    }()
    
    private let imageViewContent: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 4.0/3.0).isActive = true
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = createLabel(text: "", fontSize: 18, weight: .semibold)
        return label
    }()
    
    private let textContentLabel: UILabel = {
        let label = createLabel(text: "", fontSize: 14, weight: .light)
        label.numberOfLines = 0
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
    
    init(_ item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycles
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white

        /*
            ScrollView
                VStack
                    AdditionalHStack
                    userNameLabel
                    textContent
                    ImageView
         */
        
        // add scrollView and set constraint
        self.view.addSubview(self.scrollView)

        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

        // add view to scrollView and set constraint
        let viewContent = UIView()
        viewContent.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(viewContent)
        
        viewContent.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 0).isActive = true
        viewContent.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
        viewContent.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: 0).isActive = true
        viewContent.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 0).isActive = true
        // set width constraint to scroll only vertical
        viewContent.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: 0).isActive = true
        
        // add mainStack to viewContent
        viewContent.addSubview(self.mainStack)
        
        self.mainStack.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 12).isActive = true
        self.mainStack.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 8).isActive = true
        self.mainStack.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -12).isActive = true
        self.mainStack.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor, constant: -8).isActive = true
        
        self.additionalStack.addArrangedSubview(self.likesLabel)
        self.additionalStack.addArrangedSubview(self.viewsLabel)
        self.additionalStack.addArrangedSubview(self.commentsLabel)
        self.additionalStack.addArrangedSubview(self.shareLabel)
        self.additionalStack.addArrangedSubview(UIView())
        
        self.mainStack.addArrangedSubview(self.additionalStack)
        self.mainStack.addArrangedSubview(self.userNameLabel)
        self.mainStack.addArrangedSubview(self.textContentLabel)
        self.mainStack.addArrangedSubview(self.imageViewContent)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let author = item.author {
            userNameLabel.text = String(author.name.filter { !" \n\t\r".contains($0) })
        } else {
            userNameLabel.isHidden = true
        }
            
        textContentLabel.text = item.contents.first(where: { $0.type == .text })?.data.value
        
        likesLabel.text = String(item.stats.likes.count ?? 0)
        viewsLabel.text = String(item.stats.views.count ?? 0)
        commentsLabel.text = String(item.stats.comments.count ?? 0)
        shareLabel.text = String(item.stats.shares.count ?? 0)
        
        var data: Data? = nil

        if let path = item.contents.first(where: { $0.type == .image })?.data.small?.url {
            let url = URL(string: path)
            data = try? Data(contentsOf: url!)
        }

        imageViewContent.image = data == nil ? nil: UIImage(data: data!)
    }

}
