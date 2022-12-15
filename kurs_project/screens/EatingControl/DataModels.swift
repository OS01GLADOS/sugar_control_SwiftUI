//
//  DataModels.swift
//  kurs_project
//
//  Created by user on 15/12/2022.
//

import Foundation

struct CathegoryItem: Codable{
    let name: String?
    let count_on_XE: Int?
    let count_name: String?
    let extra_info: String?
    let amount: Int = 0
}

struct JsonItem: Codable{
    let cathegory: String?
    let items: Array<CathegoryItem>
}
