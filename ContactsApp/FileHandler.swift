//
//  FileHandler.swift
//  ContactsApp
//
//  Created by Алина Власенко on 13.04.2023.
//

import Foundation

final class FileHandler {

    private let fileManager = FileManager.default

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
