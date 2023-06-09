//
//  AddContactTableViewCell.swift
//  ContactsApp
//
//  Created by Алина Власенко on 07.04.2023.
//

import UIKit

class AddNameTableViewCell: UITableViewCell {

    static let identifier = "AddNameTableViewCell"
    
    weak var delegate: NewContactDelegate?
    
    static let shared = AddNameTableViewCell()
    
    
    //MARK: - UI objects
    public let addName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.setLeftPaddingPoints(20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        
        //addName.frame = contentView.bounds
        // add subviews
        addName.delegate = self
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
        
        NSLayoutConstraint.activate(addNameConstraints)
    }
}

// MARK: - Extension for UITextFieldDelegate
extension AddNameTableViewCell: UITextFieldDelegate {
    //метод, що бере текст, якщо він є і повертає його через делегат
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        //Показує чи працює кнопка ретурн для текст філду
        delegate?.didFillNameField(with: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //метод сгортає клавіатуру
        textField.resignFirstResponder()
        return true
    }
}
