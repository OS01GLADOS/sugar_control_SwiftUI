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

struct AddDataToDiary: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var modelData: NoteViewModel
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
                            TextField("0", text: binding(for: "\(dataItem.name!)"))

                        }
                    }
                }
            }
            Button {
                var XE = 0.0
                var res = 0.0
                for(item) in apiManager.data{
                    for dataItem in item.items{
                        if (fieldInput.keys.contains(dataItem.name!)) {
                            res = Double(fieldInput[dataItem.name!]!)! / Double(dataItem.count_on_XE!)
                            XE += res
                        }
                    }
                }
                var eatenFood = fieldInput.keys.joined(separator: " ")
                debugPrint("all eaten food: \(eatenFood), XE: \(XE)")
                // call save function
                 modelData.addData(food_eaten: eatenFood, XE: XE)
                 DispatchQueue.main.async {
                    self.isPresented = false
                }
            } label: {
                    Text("Создать")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .contentShape(Rectangle())
                }
        }
        .onAppear(perform: apiManager.get_data)
        .navigationTitle("Добавить запись")
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button(action:{
                    DispatchQueue.main.async {
                        self.isPresented = false
                    }
                }, label: {Text("Отмена")})
            }
        }
    }
       
    
}
