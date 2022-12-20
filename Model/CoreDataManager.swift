//
//  CoreDataManager.swift
//  MyCreditManager_dosh.kor
//
//  Created by 신동오 on 2022/12/06.
//

import Foundation
import CoreData 

final class CoreDataManager {
    
    // singleton
    static let shared: CoreDataManager = CoreDataManager()
    
    let modelName: String = "GradeCard"
    
    // Persistent Container load
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // Managed Object Context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveToContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func readGradeCards() -> [GradeCard] {
        var gradeCardArray:[GradeCard] = []
        let request = NSFetchRequest<NSManagedObject>(entityName: modelName)
        
        do {
            if let fetchedGradeCard = try context.fetch(request) as? [GradeCard] {
                gradeCardArray = fetchedGradeCard
            }
        } catch {
            print("read() 실패", error.localizedDescription)
        }
        
        return gradeCardArray
    }
    
    func createGradeCard(name: String, subject: String?, grade: String?) {
        if let entity = NSEntityDescription.entity(forEntityName: modelName, in: context){
            if let gradeCard = NSManagedObject(entity: entity, insertInto: context) as? GradeCard {
                gradeCard.name = name
                gradeCard.subject = subject ?? "empty"
                gradeCard.grade = grade ?? "empty"
                self.saveToContext()
            }
        }
    }
    
    func deleteGradeCard(data: GradeCard) {
                    context.delete(data)
                    self.saveToContext()
    }
}
