//
//  PersonViewController.swift
//  SeSAC_Test
//
//  Created by 김승찬 on 2021/12/28.
//

import UIKit
import SnapKit

class PersonViewController: UIViewController {
    
    private var viewModel = PersonViewModel()
    
    fileprivate var tableView = UITableView()
    fileprivate var searchBar = UISearchBar()
    
    var list: Person?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        searchBar.delegate = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        viewModel.person.bind { person in
            self.list = person
            self.tableView.reloadData()
        }
    }
}


extension PersonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.fetchPerson(query: searchBar.text!, page: 1)
    }
}

extension PersonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list?.results.count ?? 0
//        return viewModel.person.value.results.count
        return viewModel.numberOfRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = "\(data.name) | \(data.knownForDepartment)"
        return cell
    }
    
    
}
