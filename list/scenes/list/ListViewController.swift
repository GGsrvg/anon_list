//
//  ListViewController.swift
//  list
//
//  Created by GGsrvg on 02.05.2020.
//  Copyright © 2020 GGsrvg. All rights reserved.
//

import UIKit
import DataManager
import Combine

class ListViewController: UIViewController {
    
    private var list: [Item] = []
    
    var sub : AnyCancellable?
    
    private lazy var tableView: UITableView = UITableView()
    
    // MARK: Life Cycles
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        
        tableView.register(AnonTableViewCell.self, forCellReuseIdentifier: "AnonTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.init(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List"
        
        self.getPosts()
    }
    
    // MARK: Navigation
    private func goToItem(){
        let itemViewController = ItemViewController()
        navigationController!.show(itemViewController, sender: nil)
    }
    
    // MARK: Network
    private func getPosts(){
        sub = DataManager.shared.api.getPosts(first: 20, after: "", orderBy: .createdAt)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { complete in
//                switch complete{
//                case .finished:
//                    XCTAssertTrue(false)
//                case .failure(let error):
//                    XCTAssertFalse(true, error.localizedDescription)
//                }
            }, receiveValue: { data in
                for item in data.data.items {
                    self.list.append(item)
                }
                self.tableView.reloadData()
            })
    }

}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnonTableViewCell", for: indexPath) as! AnonTableViewCell
        let item = list[indexPath.row]
        
        var data: Data? = nil
        
        if let path = item.contents.first(where: { $0.type == .image })?.data.extraSmall?.url {
            let url = URL(string: path)
            data = try? Data(contentsOf: url!)
        }
        
        
        cell.setData(userName: String(item.author.name.filter { !" \n\t\r".contains($0) }),
                     textContent: item.contents.first(where: { $0.type == .text })?.data.value,
                     imageContent: data == nil ? nil: UIImage(data: data!),
                     likeCount: item.stats.likes.count ?? 0,
                     viewsCount: item.stats.views.count ?? 0,
                     commentsCount: item.stats.comments.count ?? 0,
                     shareCount: item.stats.shares.count ?? 0)
        
        return cell
    }
}

