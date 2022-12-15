//
//  EatingControlScreen.swift
//  kurs_project
//
//  Created by user on 04/12/2022.
//

import Foundation
import SwiftUI
import Alamofire
import SwiftyJSON

struct EatingControlScreen: View {
    @StateObject private var apiManager = ApiManager()
    var body: some View {
        List{
            ForEach(apiManager.data, id: \.cathegory){item in
                Section(header: Text(item.cathegory!)){
                    ForEach(item.items, id: \.name){dataItem in
                        Text(dataItem.name!)
                    }
                }
            }
        }.onAppear(perform: apiManager.get_data)
            .navigationTitle("Дневник Питания")
    }
       
    
}
