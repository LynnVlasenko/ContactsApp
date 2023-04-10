//
//  AddContactVC.swift
//  ContactsApp
//
//  Created by Алина Власенко on 07.04.2023.
//
// + створюємо масив для збереження даних
//картинку, леблу під нею і табличку
//далі в селі створюємо елементи, що будуть в табличці - і там же передаємо дані з моделі

import UIKit

protocol SetContactsDelegate {
    func getContact(contact: ContactData)
}

class AddContactVC: UIViewController {
    
    var delegate: SetContactsDelegate?
    
    private var name: String?
    private var surname: String?
    private var phone: String?
    
    
    //MARK: - UI Elements
    
    private let userImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "user")
        img.layer.cornerRadius = 105
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        //img.backgroundColor = .gray
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let addPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Додати фото", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let addContactTable: UITableView = {
        let table = UITableView()
        table.register(AddNameTableViewCell.self, forCellReuseIdentifier: AddNameTableViewCell.identifier)
        table.register(AddSurnameTableViewCell.self, forCellReuseIdentifier: AddSurnameTableViewCell.identifier)
        table.register(AddPhoneTableViewCell.self, forCellReuseIdentifier: AddPhoneTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        configureNavBar()
        addSubviews()
        applyConstraints()
        applyDelegates()
    }
    
    //MARK: - viewDidLayoutSubviews
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        addContactTable.frame = view.bounds
//    }
    
    private func addSubviews() {
        view.addSubview(userImage)
        view.addSubview(addPhotoButton)
        view.addSubview(addContactTable)
    }
    
    private func configureNavBar() {
        //let nav = UINavigationController(rootViewController: AddContactVC())
        title = "New Contact"
        //також чомусь не робиться заголовок звичайним
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemOrange
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem?.isHidden = true
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Dismiss", style: .done, target: self, action: #selector(cancleAction))
        
   }
    
//MARK: - Actions
    
    @objc func didTapDone() {
        
        guard let name = name, let surname = surname, let phone = phone else { return }

        let model = ContactData(name: name, surname: surname, phoneNumber: phone)

        delegate?.getContact(contact: model)
        //оновити табличку ContactsVC - для відображення даних контакту - сортоване відображення
        //коли фото не буде завантажено - замість заглушки - поставити UIView сірого кольору - на якому зверху буде лейбла перша буква імені білого кольору - підготувати дизайн, розмістити поверх картинки і включати чи відключати відображення цієї в'юшки.
        //тут же прописати функцію збереження фото в папку Документи. (створити її можна поза межами кнопки - тут виконати)
        //тут же дані мають зберегтися в plist, і потім прописати відобрадення цих даних на ContactsVC при відкритті застосунку
        
        navigationController?.popViewController(animated: false)
        print("name: \(name) surname: \(surname), phone: \(phone)")
    }
    
    private func applyConstraints() {
        let userImageConstraints = [
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userImage.widthAnchor.constraint(equalToConstant: 210),
            userImage.heightAnchor.constraint(equalToConstant: 210)
        ]
        
        let addPhotoButtonConstraints = [
            addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addPhotoButton.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10)
        ]
        
        let addContactTableConstraints = [
            addContactTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addContactTable.topAnchor.constraint(equalTo: addPhotoButton.bottomAnchor, constant: 30),
            addContactTable.widthAnchor.constraint(equalToConstant: view.frame.width),
            addContactTable.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        NSLayoutConstraint.activate(userImageConstraints)
        NSLayoutConstraint.activate(addPhotoButtonConstraints)
        NSLayoutConstraint.activate(addContactTableConstraints)
    }
}

extension AddContactVC: UITableViewDataSource, UITableViewDelegate {
    
    private func applyDelegates() {
        addContactTable.delegate = self
        addContactTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 2 {
            guard let phoneCell = tableView.dequeueReusableCell(withIdentifier: AddPhoneTableViewCell.identifier, for: indexPath) as? AddPhoneTableViewCell else { return UITableViewCell()}
            //підписуєіо делегат комірки - це змушує підпорядкувати вью контроллер до протоколу NewContactDelegate, (делегат, якого переданий в комірках) і виконати усі його функції, що ми робимо в екстеншені
            phoneCell.delegate = self
            return phoneCell
        }
        
        if indexPath.row == 1 {
            guard let surnameCell = tableView.dequeueReusableCell(withIdentifier: AddSurnameTableViewCell.identifier, for: indexPath) as? AddSurnameTableViewCell else { return UITableViewCell()}
            //підписуєіо делегат комірки - це змушує підпорядкувати вью контроллер до протоколу NewContactDelegate, (делегат, якого переданий в комірках) і виконати усі його функції, що ми робимо в екстеншені
            surnameCell.delegate = self
            return surnameCell
        }
        
        guard let nameCell = tableView.dequeueReusableCell(withIdentifier: AddNameTableViewCell.identifier, for: indexPath) as? AddNameTableViewCell else { return UITableViewCell()}
        //підписуєіо делегат комірки - це змушує підпорядкувати вью контроллер до протоколу NewContactDelegate, (делегат, якого переданий в комірках) і виконати усі його функції, що ми робимо в екстеншені
        nameCell.delegate = self
        return nameCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension AddContactVC: NewContactDelegate {
    
    func didFillNameField(with text: String) {
        //Щоб кнопка done зʼявлялася тільки коли всі поля заповнені
        if (surname != nil && surname != "") && (phone != nil && phone != "") {
            navigationItem.rightBarButtonItem?.isHidden = false
        }
        name = text //створена порожня змінна name = отриманий текст - якиq дає нам реалізована функція didFillNameField в textFieldDidEndEditing методі в AddNameTableViewCell.swift
    }
    
    func didFillSurnameField(with text: String) {
        if (name != nil && name != "") && (phone != nil && phone != "") {
            navigationItem.rightBarButtonItem?.isHidden = false
        }
        surname = text
    }
    
    func didFillPhoneField(with text: String) {
        if (name != nil && name != "") && (surname != nil && surname != "") {
            navigationItem.rightBarButtonItem?.isHidden = false
        }
        phone = text
    }
}
