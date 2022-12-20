//
//  GradeCard+CoreDataProperties.swift
//  MyCreditManager_dosh.kor
//
//  Created by 신동오 on 2022/12/06.
//
//

import Foundation
import CoreData


extension GradeCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GradeCard> {
        return NSFetchRequest<GradeCard>(entityName: "GradeCard")
    }

    @NSManaged public var grade: String?
    @NSManaged public var name: String?
    @NSManaged public var subject: String?

}

extension GradeCard : Identifiable {

}
