//
//  Note.swift
//  kurs_project
//
//  Created by user on 15/12/2022.
//

import RealmSwift
import SwiftUI

class Note : Object, Identifiable{
    @objc dynamic var id : Date = Date()
    @objc dynamic var date : Date = Date()
    @objc dynamic var food_eaten = ""
    @objc dynamic var xe_record = 0.0
}
