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

//створюємо протокол для витягування даних з поля вводу. Реалізовуємо його в AddContactVC
protocol NewContactDelegate: AnyObject {
    func didFillNameField(with text: String)
    func didFillSurnameField(with text: String)
    func didFillPhoneField(with text: String)
}

class ContactsVC: UIViewController {

    //для реалізації трекеру кількості відкриття програми.
    let userDefaults = UserDefaults.standard
    // tracker
    var openedCount = 0
    
    //the ampty array to store data with the type of our ContactData model
    //var contacts = [ContactData]()
    var contacts = [Contact]()
    
    // MARK: - UI
    let contactsTable: UITableView = {
        let table = UITableView()
        table.register(ContactsTableViewCell.self, forCellReuseIdentifier: ContactsTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //open tracker
        opensTracker()
        //load contacts ////реалізувати відображення даних контактів, які вже створені(з plist). щоб відобразилися при відкритті програми.
        contacts = FileHandler.shared.loadContacts()
        view.addSubview(contactsTable)
        //configureNavBar()
        applyDelegates()
        print(FileHandler.shared.printPath())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contactsTable.frame = view.bounds
    }
    
    //пропусуємо НавБар таким чином, щоб оновлювався вигляд кожного разу як з'являється. Бо інакше підхоплює вигляд іншого вью контроллера з малим заголовком.
    override func viewWillAppear(_ animated: Bool) {
        configureNavBar()
    }

    //MARK: - NavigationBar
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
    
    //MARK: - Actions
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
    
    //MARK: - Tracker
    //Через userDefaults і UIAlertController трекаємо кількість разів відкриття застосунку. якщо відкриваємо кожен 3-тій раз - то викликається алерт.
    //Тут спочатку тягнемо значення. Збільшуємо. Вставляємо. Синхронезуємо. Потім перевірка. Якщо кратне 3 - Робимо алерт. Робимо екшн. Презентуємо
    func opensTracker() {
        openedCount = userDefaults.integer(forKey: "OpenedCount")
        openedCount += 1
        userDefaults.set(openedCount, forKey: "OpenedCount")
        userDefaults.synchronize()
        
        if openedCount % 3 == 0 {
            let alert = UIAlertController(title: "Info", message: "Ви відкрили програму \(openedCount) разів", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(alertAction)
            present(alert, animated: true)
        }
    }
}

// MARK: - Extension for Protocol - SetContactsDelegate
//реалізовуємо протокол SetContactsDelegate для виведення даних контакту у табличку контактів. Протокол створений в AddContactVC
extension ContactsVC: SetContactsDelegate {
    func updateContacts() {
        DispatchQueue.main.async {
            self.contacts = FileHandler.shared.loadContacts() //передаємо функцію яка витягує дані контакта з plist-a (після його збереження в plist по натисканню кнопкі Done) та додає його в масив контактів. таким чином ми присвоюємо той масив з функції до нашого масиву contacts в контроллері
            self.contacts = self.contacts.sorted { $0.name.lowercased() < $1.name.lowercased() } //сортуємо наш масив
            self.contactsTable.reloadData() // і виконує метод оновити табличку - коли табличка починає оновлючатися іде перевірка у екстеншені нижче у функції з методом cellForRowAt - бачить що indexPath.section більше не 0 - і відображає AlarmTableViewCell на нашому поточному вью
            }

        //Попередня реалізація - без plist-a
//    func getContact(contact: ContactData) {
//        DispatchQueue.main.async {
//            self.contacts.append(contact) //додає contact дані до масиву contacts
//            self.contacts = self.contacts.sorted { $0.name.lowercased() < $1.name.lowercased() } //сортуємо наш масив
//            self.contactsTable.reloadData() // і виконує метод оновити табличку
//        }
    }
}

// MARK: - Extension for Table
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
    
    //для видалення котакту
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = contacts[indexPath.row].id
            FileHandler.shared.deleteContact (id: id)
            contacts = FileHandler.shared.loadContacts()
            tableView.deleteRows (at: [indexPath], with: .fade)
        }
    }
}
