//
//  LocalFileManager.swift
//  MyCreditManager_2_rmadyd123456
//
//  Created by Swain Yun on 2023/08/14.
//

import Foundation

class LocalFileManager {
    static let shared = LocalFileManager()

    private let folderName: String = "AppDocuments"
    private let fileName: String = "StudentDatabase"

    private init() {
        createFolderIfNeeded()
    }
}

// MARK: Internal Methods
extension LocalFileManager {
    func saveData(data: Data) {
        guard let jsonFileURL = getJSONFileURL() else { return }
        try? data.write(to: jsonFileURL)
    }
    
    func fetchData() -> Data? {
        guard let jsonFileURL = getJSONFileURL(), FileManager.default.fileExists(atPath: jsonFileURL.path()) else { return nil }
        return try? Data(contentsOf: jsonFileURL)
    }
}

// MARK: Private Methods
extension LocalFileManager {
    private func getDocumentDirectoryURL() -> URL? {
        guard let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectoryURL
    }

    private func getFolderURL() -> URL? {
        guard let documentDirectoryURL = getDocumentDirectoryURL() else { return nil }
        let folderURL = documentDirectoryURL.appendingPathComponent(folderName)
        return folderURL
    }

    private func getJSONFileURL() -> URL? {
        guard let folderURL = getFolderURL() else { return nil }
        let fileURL = folderURL.appendingPathComponent(fileName).appendingPathExtension("json")
        return fileURL
    }

    private func createFolderIfNeeded() {
        guard let folderURL = getFolderURL() else { return }
        
        // StudentDatabase.json을 저장할 폴더가 없을 경우에 지정된 경로로 폴더 생성
        guard FileManager.default.fileExists(atPath: folderURL.path()) == false else { return }
        try? FileManager.default.createDirectory(at: folderURL, withIntermediateDirectories: true)
    }
}
