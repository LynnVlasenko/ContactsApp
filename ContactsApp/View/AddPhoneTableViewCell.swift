//
//  AddContactTableViewCell.swift
//  ContactsApp
//
//  Created by Алина Власенко on 07.04.2023.
//

import UIKit

class AddPhoneTableViewCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "AddPhoneTableViewCell"
    
    static let shared = AddPhoneTableViewCell()
    
    public var phoneData: String = "phone"
    
    //MARK: - UI objects
    
    private let addPhone: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone"
        textField.setLeftPaddingPoints(20)
        //call up the numeric keypad
        textField.keyboardType = UIKeyboardType.phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
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
        contentView.addSubview(addPhone)
    }
    
    //MARK: - Apply constraints
    private func applyConstraints() {
        
        let addPhoneConstraints = [
            addPhone.topAnchor.constraint(equalTo: contentView.topAnchor),
            addPhone.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addPhone.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            addPhone.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(addPhoneConstraints)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        phoneData = addPhone.text ?? "p"
    }
    
    public func configure(with model: ContactData) {
        phoneData = model.phoneNumber ?? "ph"
    }
}
