//
//  ContactModal.swift
//  ContactsApp
//
//  Created by Алина Власенко on 07.04.2023.
//

import Foundation
import UIKit

struct ContactData: Codable {
    let name: String
    let surname: String
    let phoneNumber: String
    //let photo: UIImage?
}

struct ContactPhoto {
    let photo: UIImage?
}
