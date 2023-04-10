//
//  UITextFieldExtension.swift
//  ContactsApp
//
//  Created by Алина Власенко on 09.04.2023.
//

import UIKit

//для відступу зліва для тексту в TextField
extension UITextField {

    func setLeftPaddingPoints(_ amount:CGFloat){
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
}
