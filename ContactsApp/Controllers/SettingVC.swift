//
//  SettingVC.swift
//  ContactsApp
//
//  Created by Алина Власенко on 09.04.2023.
//

import UIKit

class SettingVC: UIViewController {
    
    let settingsTable: UITableView = {
        let table = UITableView()
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        view.addSubview(settingsTable)
        applyDelegates()
    }
    
    //MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        settingsTable.frame = view.bounds
    }
    
    private func configureNavBar() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemOrange
   }
}

// MARK: - Extension for Table
extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    
    private func applyDelegates() {
        settingsTable.delegate = self
        settingsTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell()}
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
