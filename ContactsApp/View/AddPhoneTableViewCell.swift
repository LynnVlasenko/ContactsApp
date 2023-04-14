//
//  AddContactTableViewCell.swift
//  ContactsApp
//
//  Created by Алина Власенко on 07.04.2023.
//

import UIKit

class AddPhoneTableViewCell: UITableViewCell {

    static let identifier = "AddPhoneTableViewCell"
    
    weak var delegate: NewContactDelegate?
    
    static let shared = AddPhoneTableViewCell()
    
    //MARK: - UI objects
    
    public let addPhone: UITextField = {
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
        
        addPhone.delegate = self
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
}

// MARK: - Extension for UITextFieldDelegate
extension AddPhoneTableViewCell: UITextFieldDelegate {
    //метод, що бере текст, якщо він є і повертає його через делегат
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        //Показує чи працює кнопка ретурн для текст філду
        delegate?.didFillPhoneField(with: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //метод сгортає клавіатуру
        textField.resignFirstResponder()
        return true
    }
}
