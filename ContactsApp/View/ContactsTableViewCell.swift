//
//  ContactsTableViewCell.swift
//  ContactsApp
//
//  Created by Алина Власенко on 07.04.2023.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    static let identifier = "ContactsTableViewCell"
    
    //MARK: - UI Elements
    private let userImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "user")
        img.layer.cornerRadius = 30
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        //img.backgroundColor = .gray
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let nameLbl: UILabel = {
        let label = UILabel()
        //label.text = передати в конфігурації дані з моделі name + surname
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneLbl: UILabel = {
        let label = UILabel()
        //label.text = передати в конфігурації дані з моделі - phone Number
        label.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        
        addSubviews()
        applyConstraints()
    }
    
    //з'являється автоматично після створення iніту, після натискання на помилку до ініту.
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        contentView.addSubview(userImage)
        contentView.addSubview(nameLbl)
        contentView.addSubview(phoneLbl)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let userImageConstraints = [
            userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            userImage.widthAnchor.constraint(equalToConstant: 60),
            userImage.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        let nameLblConstraints = [
            nameLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLbl.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 20)
        ]
        
        let phoneLblConstraints = [
            phoneLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            phoneLbl.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(userImageConstraints)
        NSLayoutConstraint.activate(nameLblConstraints)
        NSLayoutConstraint.activate(phoneLblConstraints)
    }
    
    //MARK: - Configure cell
    
    public func configure(with model: Contact) {
        nameLbl.text = "\(model.name) \(model.surname)"
        phoneLbl.text = model.phoneNumber
        userImage.image = UIImage(data: model.photo)
    }
    
    //Попередній вигляд - без plist
//    public func configure(with model: ContactData) {
//
//        nameLbl.text = "\(model.name) \(model.surname)"
//        phoneLbl.text = model.phoneNumber
//        //userImage.image = model.photo
//    }
//
//    public func configure(with model: ContactPhoto) {
//        userImage.image = model.photo
//    }
}
