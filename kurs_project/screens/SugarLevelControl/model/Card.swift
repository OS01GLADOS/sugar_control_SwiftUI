//
//  Card.swift
//  kurs_project
//
//  Created by user on 13/12/2022.
//

import RealmSwift
import SwiftUI

class Card : Object, Identifiable{
    @objc dynamic var id : Date = Date()
    @objc dynamic var date : Date = Date()
    @objc dynamic var value = ""
}
