//
//  AddContactTableViewCell.swift
//  ContactsApp
//
//  Created by Алина Власенко on 07.04.2023.
//

import UIKit

class AddSurnameTableViewCell: UITableViewCell {

    static let identifier = "AddSurnameTableViewCell"
    
    weak var delegate: NewContactDelegate?
    
    static let shared = AddSurnameTableViewCell()
    
    //public var surnameData: String = "surname"
    
    //MARK: - UI objects
    
    public let addSurname: UITextField = {
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
        
        addSurname.delegate = self
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
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        surnameData = addSurname.text ?? "s"
//    }
//    
//    public func configure(with model: ContactData) {
//        surnameData = model.surname ?? "su"
//    }
}


extension AddSurnameTableViewCell: UITextFieldDelegate {
    //метод, що бере текст, якщо він є і повертає його через делегат
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        //Показує чи працює кнопка ретурн для текст філду
        delegate?.didFillSurnameField(with: text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //метод сгортає клавіатуру
        textField.resignFirstResponder()
        return true
    }
}
