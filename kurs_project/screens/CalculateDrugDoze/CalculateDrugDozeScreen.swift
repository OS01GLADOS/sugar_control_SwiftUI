//
//  CalculateDrugDozeScreen.swift
//  kurs_project
//
//  Created by user on 04/12/2022.
//

import Foundation

import SwiftUI
import Combine


struct CalculateDrugDozeScreen: View {
    
    @State private var weight = ""
    @State private var DrugDozeResult = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(DrugDozeResult)").font(.system(size: 70))
            Text("Ваш вес:")
            TextField("Введите вес в кг", text: $weight)
                       .onReceive(Just(weight)) { newValue in
                           let filtered = newValue.filter { "0123456789.".contains($0) }
                           if filtered != newValue {
                               self.weight = filtered
                           }
                       }
            Button(action: calulateDrug) {
                Label("Рассчитать", systemImage: "plus")
                }
            }.frame(alignment:Alignment.leading)
        .padding(10)
        .navigationTitle("Расчет инсулина")
        }
        
    private func calulateDrug(){
        var input: Double? = Double(weight)
        // call function
        // assign res to str
        var res: Double
        guard input != nil  else {
              return
            }
        res = input!
        DrugDozeResult = String(format: "%.2f mg", res)
    }
}
