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
    
    private var isLoading = false
    
    private var cursor = ""
    
    private var oldDrderBy: OrderBy = .createdAt
    
    private var list: [Item] = []
    
    private var sub : AnyCancellable?
    
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
        NSLayoutConstraint.init(item: view!, attribute: .bottom, relatedBy: .equal, toItem: tableView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint.init(item: view!, attribute: .trailing, relatedBy: .equal, toItem: tableView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "List"
        
        let changeSortButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(selectSort))

        navigationItem.rightBarButtonItems = [changeSortButtonItem]
        
        self.getPosts(orderBy: .mostPopular)
    }
    
    @objc func selectSort(){
        let optionMenu = UIAlertController(title: nil, message: "Choose type sort", preferredStyle: .actionSheet)
            
        let mostCommentedAction = UIAlertAction(title: "Most commented", style: .default, handler: { _ in self.getPosts(orderBy: .mostCommented, loading: false) })
        let mostPopularAction = UIAlertAction(title: "Most popular", style: .default, handler: { _ in self.getPosts(orderBy: .mostPopular, loading: false) })
        let createAtAction = UIAlertAction(title: "Create at", style: .default, handler: { _ in self.getPosts(orderBy: .createdAt, loading: false) })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(mostCommentedAction)
        optionMenu.addAction(mostPopularAction)
        optionMenu.addAction(createAtAction)
        optionMenu.addAction(cancelAction)
            
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    // MARK: Navigation
    private func goToItem(_ item: Item){
        let itemViewController = ItemViewController(item)
        navigationController!.show(itemViewController, sender: nil)
    }
    
    // MARK: Data
    private func getPosts(orderBy: OrderBy, loading: Bool = true){
        self.isLoading = true
        
        sub = DataManager.shared.api.getPosts(first: 20, after: loading ? cursor : "", orderBy: orderBy)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { complete in
                switch complete{
                case .failure(let error):
                    print("ERROR: \(error)")
                case .finished:
                    break
                }
                self.isLoading = false
            }, receiveValue: { data in
                print("CURSOR = \(data.data.cursor)")
                
                if !loading {
                    self.list.removeAll()
                    self.tableView.scrollRectToVisible(.zero, animated: true)
                }
                
                for item in data.data.items {
                    self.list.append(item)
                }
                self.tableView.reloadData()
                
                self.cursor = data.data.cursor
                self.isLoading = false
            })
        
        self.oldDrderBy = orderBy
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnonTableViewCell", for: indexPath) as! AnonTableViewCell
        let item = list[indexPath.row]
        
        cell.setData(userName:      item.author != nil ? String(item.author!.name.filter { !" \n\t\r".contains($0) }) : nil,
                     textContent:   item.contents.first(where: { $0.type == .text })?.data.value,
                     imageContent:  nil,
                     likeCount:     item.stats.likes.count ?? 0,
                     viewsCount:    item.stats.views.count ?? 0,
                     commentsCount: item.stats.comments.count ?? 0,
                     shareCount:    item.stats.shares.count ?? 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.goToItem(list[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !isLoading && indexPath.row > list.count - 2 {
            getPosts(orderBy: oldDrderBy)
        }
    }
}
