//
//  ViewController.swift
//  ContactsApp
//
//  Created by Алина Власенко on 07.04.2023.
//

//зробити по натисканюю на + - відображення нового вікна (нового вью контроллера) - де я заповнюю дані
//зробити, щоб дані зберігалися в модель даних.
//зробити відображення нового контакту на головному вью контроллері.

import UIKit

protocol NewContactDelegate: AnyObject {
    func didFillNameField(with text: String)
    func didFillSurnameField(with text: String)
    func didFillPhoneField(with text: String)
}

class ContactsVC: UIViewController {

    
    //the ampty array to store data with the type of our ContactData model
    var contacts = [ContactData]()
    
    let contactsTable: UITableView = {
        let table = UITableView()
        table.register(ContactsTableViewCell.self, forCellReuseIdentifier: ContactsTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(contactsTable)
        configureNavBar()
        applyDelegates()
        //реалізувати відображення даних контактів, які вже створені(з plist). щоб відобразилися при відкритті програми.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contactsTable.frame = view.bounds
    }

    private func configureNavBar() {
        title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemOrange
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .done,
            target: self,
            action: #selector(didTapSetting))
   }
    
    @objc func didTapAdd() {
        let vc = AddContactVC()
        vc.delegate = self //обовьязково треба підписатися під делегат бо він створений в середині AddContactVC() - інакше не запрацює
        navigationController?.pushViewController(vc, animated: true)
        //let nav = UINavigationController(rootViewController: vc)
        //чомусь не працював showDetailViewController - в чому може бути проблема?
        //showDetailViewController(vc, sender: self)
        //configureNavBar()
        //showDetailViewController(vc, sender: self)
    }
    
    @objc func didTapSetting() {
        let vc = SettingVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ContactsVC: SetContactsDelegate {
    
    func getContact(contact: ContactData) {
        DispatchQueue.main.async {
            self.contacts.append(contact) //додає contact дані до масиву contacts
            self.contacts = self.contacts.sorted { $0.name.lowercased() < $1.name.lowercased() } //сортуємо наш масив
            self.contactsTable.reloadData() // і виконує метод оновити табличку - коли табличка починає оновлючатися іде перевірка у екстеншені нижче у функції з методом cellForRowAt - бачить що indexPath.section більше не 0 - і відображає AlarmTableViewCell на нашому поточному вью
        }
    }
    
}

extension ContactsVC: UITableViewDataSource, UITableViewDelegate {
    
    private func applyDelegates() {
        contactsTable.delegate = self
        contactsTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactsTableViewCell.identifier, for: indexPath) as? ContactsTableViewCell else { return UITableViewCell()}
        let model = contacts[indexPath.row]
        cell.configure(with: model)
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
