//
//  ContactModal.swift
//  ContactsApp
//
//  Created by Алина Власенко on 07.04.2023.
//

import Foundation

struct ContactData: Codable {
    let name: String
    let surname: String
    let phoneNumber: String
}

struct ContactPhoto: Codable {
    let photo: URL?
}
