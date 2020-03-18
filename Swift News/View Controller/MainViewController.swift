//
//  MainViewController.swift
//  Swift News
//
//  Created by Leon Chen on 2020-03-17.
//  Copyright © 2020 LeonChen. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    var feedService: FeedService!
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var feedTableView: UITableView!
    
    private var loading: Bool = false {
        didSet {
            loadingLabel.isHidden = !loading
        }
    }
    
    private var feedItems: [FeedChild] = [] {
        didSet {
            feedTableView.reloadData()
        }
    }
    
    private func setupUI() {
        loadingLabel.isHidden = false
        feedTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        fetchData()
    }
    
    private func fetchData() {
        loading = true
        
        feedService.fetchFeed { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let listing):
                self.feedItems = listing.data.children
            case .failure:
                self.showError()
            }
            
            self.loading = false
        }
    }
    
    private func showError() {
        let alert = UIAlertController(title: "Error", message: "Loading failed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self]  _ in
            guard let self = self else { return }
            
            self.fetchData()
        }))
        
        present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = feedItems[indexPath.row].data
        
        if let url = URL(string: item.url) {
            let vc = vcFactory.createDetailsViewController(title: item.title,
                                                           thumbnailUrl: URL(string: item.thumbnail),
                                                           webUrl: url)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedItemTableViewCell") as? FeedItemTableViewCell {
            let item = feedItems[indexPath.row].data
            cell.config(title: item.title, thumbnailUrl: item.thumbnail)
            return cell
        }
        
        return UITableViewCell()
    }
}
