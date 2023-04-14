//
//  FileHandler.swift
//  ContactsApp
//
//  Created by Алина Власенко on 13.04.2023.
//

import Foundation

final class FileHandler {
    
    //створюємо сінглтон
    static let shared = FileHandler()
    
    //І всі необхідні константи
    //створюємо файл менеджер
    private let fileManager = FileManager.default
    //посилання на папку Documents у нашому проекті
    private let mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    //?
    private let contactsPath: URL

    // MARK: - Init
    //Робимо ініт. Де ми будемо створювати нову дерикторію, якщо її ще немає і запишемо цю адресу у contactsPath
    private init() {
        contactsPath = mainPath.appending(path: "Contacts", directoryHint: .isDirectory)
        
        // directiry check
        if !fileManager.fileExists(atPath: contactsPath.path()) {
            do {
                try fileManager.createDirectory (at: contactsPath, withIntermediateDirectories: true)
                print ("Created contacts directory")
                print(contactsPath)
            } catch {
                print ("FAILE TO CREATE DIRECTORY Contacts DUE TO: \(error.localizedDescription) ")
            }
        }
    }
    
    func printPath() {
        print(contactsPath)
    }
    
    // MARK: - Save contact
    //Метод saveContact. Він приймає модель контакт. Створює plist файл з назвою id. Енкодимо дані в plist. І зберігаємо
    //Тобто - тут відбувається запис даних в Plist>
    
    func saveContact(_ contact: Contact) {
        //створюємо plist для збереження даних контактів
        let contactPath = contactsPath.appending(path: "\(contact.id).plist")
        do {
            //намагаємося енкодувати дані в plist
            let contactData = try PropertyListEncoder().encode(contact) //в уроці ми тут вказувати. що PropertyListEncoder() має бути в .xmlформаті.
            //записуємо отримані дані по шляху
            try contactData.write(to: contactPath)
            print ("Contact saved")
        } catch {
            print ("FAILED TO SAVE CONTACT DUE TO: \(error.localizedDescription)")
        }
    }
    
    //MARK: - load Contact
    //А тут читання даних з plist-a
    //Робимо метод loadContact. Який повертає контакт за id. Декодимо дані з plist-a
    private func loadContact(id: String) -> Contact? {
        let contactPath = contactsPath.appending(path: "\(id).plist")
        do {
            let contactData = try Data (contentsOf: contactPath)
            let contact = try PropertyListDecoder().decode(Contact.self, from: contactData)
            return contact
        } catch {
            print ("FAILED TO LOAD THE CONTACT DUE TO: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - load Contacts
    //Робимо метод який повертає всі контакти. Всі id ми отримуємо з функції getAllContactsIds()
    func loadContacts () -> [Contact] {
        let ids = getAllContactsIds() //це по факту масив стрінгів з id-шніками
        //порожній масив
        var contacts = [Contact]()
        
        for id in ids {
            //якщо контакт є, тобто витягнувся по функції loadContact по певному id з усіх ids  в getAllContactsIds() - це по факту масив стрінгів з id-шніками
            if let contact = loadContact(id: id) {
                //то додаємо цей контакт в наш порожній масив контактів
                contacts.append(contact)
            } else {
                continue //забула що означає continue //Continue - вказує поточному циклу, що слід припинити виконання поточної ітерації та почати наступну ітерацію циклу. Вона каже "я закінчив із поточною ітерацією циклу" без повного виходу із циклу.
            }
        }
        return contacts
    }
    
    //MARK: - Get all contacts ids
    //Всі id ми отримуємо з цієї функції.
    private func getAllContactsIds () -> [String] {
        //бере всі назви файлів з директорії
        guard let fullIds = try? fileManager.contentsOfDirectory(atPath: contactsPath.path()) else { return [String]()}
        //прибирає останні 6 символів. Бо останні символи це тип файлу. Наприклад HHF-7FHH.plist
        let results = fullIds.map { String($0.dropLast(6)) }
        return results
    }
    
    // MARK: - Remove Contact
    //мабудь будемо передавати цю функцію, коли будемо видаляти рядок таблички з контактами.
    func deleteContact(id: String) {
        let contactPath = contactsPath.appending(path: "\(id).plist")
        do {
            try fileManager.removeItem(at: contactPath)
        } catch {
            print ("FAILED TO REMOVE CONTACT DUE TO: \(error.localizedDescription)")
        }
    }
    
    
    //отримуємо нашу поточну директорію в Сендбоксі проекту
    private var documentDirectory : URL? {
        get { //використовуємо тільки гет - так як ми можемо лише отримати шлях і нічого не будемо сюди сетити
            guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                return nil
            }
            return documentDirectory
        }
    }

    func createPhotoDir() {
        guard let documentDirectory = documentDirectory else { return } //розгортаємо опціонал - так як наша documentDirectory є опціональною. І вже після гуарду - вона перестає бути опціональною і ми працюємо з нею як зі звичайною урлою url

        // create a directory in Documents
        do {
            var isDirectory: ObjCBool = true
            let photoDir = documentDirectory.appendingPathComponent("Photo", isDirectory: true)
            if !fileManager.fileExists(atPath: photoDir.absoluteString, isDirectory: &isDirectory) {
                try fileManager.createDirectory(at: photoDir, withIntermediateDirectories: false, attributes: nil)
            }
            print(photoDir)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

//    func createTestFileInTestDir() {
//        guard let testPath = documentDirectory?.appendingPathComponent("TestDir/testfile.txt").path else { return }
//
//        if fileManager.fileExists(atPath: testPath) {
//            print("File is already exists")
//        } else {
//            fileManager.createFile(atPath: testPath, contents: nil, attributes: nil)
//        }
//        print(testPath)
//    }
}
