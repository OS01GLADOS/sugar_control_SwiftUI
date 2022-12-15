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
    @State var fieldInput: [String: String] = [:]
    @State private var name = ""
    
    private func binding(for key: String) -> Binding<String> {
        return .init(
            get: { self.fieldInput[key, default: ""] },
            set: { self.fieldInput[key] = $0 })
    }
    
    
    var body: some View {
        List{
            ForEach(apiManager.data, id: \.cathegory){item in
                DisclosureGroup(item.cathegory!){
                    ForEach(item.items, id: \.name){dataItem in
                        DisclosureGroup(dataItem.name!){
                            if ((dataItem.extra_info!) != ""){
                                Text("Одной ХЕ примерно соответствует \(dataItem.extra_info!)")
                            }
                            Text("Введите количество съеденных продуктов в \"\(dataItem.count_name!)\"")
                            TextField("0", text: binding(for: "\(item.cathegory!)_\(dataItem.name!)"))

                        }
                    }
                }
            }
            
        }
        .onAppear(perform: apiManager.get_data)
        .navigationTitle("Добавить запись")
    }
       
    
}
