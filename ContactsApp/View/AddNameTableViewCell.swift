//
//  AddContactTableViewCell.swift
//  ContactsApp
//
//  Created by Алина Власенко on 07.04.2023.
//

import UIKit

class AddNameTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "AddNameTableViewCell"
    
    static let shared = AddNameTableViewCell()
    
    public var nameData: String = "name"
    //static let shared = AddContactTableViewCell()
    
    //MARK: - UI objects
    public let addName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.setLeftPaddingPoints(20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
//    private let addSurname: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Surname"
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
//
//    private let addPhone: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Телефон"
//        //тут треба якось викликати цифрофу клавіатуру при натисканні на поле
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        
        //addName.frame = contentView.bounds
        // add subviews
        addSubviews()
        
        //apply constraints
        applyConstraints()
    }
    //поки що не дуже розумію для чого ця штука, але має бути
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        contentView.addSubview(addName)
//        contentView.addSubview(addSurname)
//        contentView.addSubview(addPhone)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        let addNameConstraints = [
            addName.topAnchor.constraint(equalTo: contentView.topAnchor),
            addName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addName.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            addName.heightAnchor.constraint(equalToConstant: 50)
        ]
        
//        let addSurnameConstraints = [
//            addSurname.topAnchor.constraint(equalTo: addName.topAnchor),
//            addSurname.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            addSurname.widthAnchor.constraint(equalToConstant: contentView.frame.width),
//            addSurname.heightAnchor.constraint(equalToConstant: 50)
//        ]
//        
//        let addPhoneConstraints = [
//            addPhone.topAnchor.constraint(equalTo: addSurname.topAnchor),
//            addPhone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            addPhone.widthAnchor.constraint(equalToConstant: contentView.frame.width),
//            addPhone.heightAnchor.constraint(equalToConstant: 50)
//        ]
        
        NSLayoutConstraint.activate(addNameConstraints)
//        NSLayoutConstraint.activate(addSurnameConstraints)
//        NSLayoutConstraint.activate(addPhoneConstraints)
    }
    
    //MARK: - Configure cell
//    private var addData = [UITextField]()
//
//    private func addTextFielf() {
//        addData.append(addName)
//        addData.append(addName)
//        addData.append(addName)
//    }
//
//    func getTextField() -> [UITextField] {
//        return addData
//    }
    
//    public func saveName() {
//        nameData.append(addName.text ?? "")
//    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) -> String {
        nameData = addName.text ?? "n"
        return nameData
    }
    
    public func configure(with model: ContactData) {
        nameData = model.name ?? "nm"
    }
}
