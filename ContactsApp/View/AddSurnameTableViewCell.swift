//
//  AddContactTableViewCell.swift
//  ContactsApp
//
//  Created by Алина Власенко on 07.04.2023.
//

import UIKit

class AddSurnameTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "AddSurnameTableViewCell"
    
    static let shared = AddSurnameTableViewCell()
    
    public var surnameData: String = "surname"
    
    //MARK: - UI objects
    
    private let addSurname: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Surname"
        textField.setLeftPaddingPoints(20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground

        // add subviews
        addSubviews()
        
        //apply constraints
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Add subviews
    private func addSubviews() {
        contentView.addSubview(addSurname)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let addSurnameConstraints = [
            addSurname.topAnchor.constraint(equalTo: contentView.topAnchor),
            addSurname.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addSurname.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            addSurname.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(addSurnameConstraints)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        surnameData = addSurname.text ?? "s"
    }
    
    public func configure(with model: ContactData) {
        surnameData = model.surname ?? "su"
    }
}
