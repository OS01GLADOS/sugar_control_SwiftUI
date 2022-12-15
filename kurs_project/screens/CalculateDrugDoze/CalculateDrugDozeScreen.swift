//
//  CalculateDrugDozeScreen.swift
//  kurs_project
//
//  Created by user on 04/12/2022.
//

import Foundation

import SwiftUI
import Combine

struct BounceAnimationView: View {
    let characters: Array<String.Element>
    
    @State var offsetYForBounce: CGFloat = -50
    @State var opacity: CGFloat = 0
    @State var baseTime: Double
    
    init(text: String, startTime: Double){
        self.characters = Array(text)
        self.baseTime = startTime
    }
    
    var body: some View {
        HStack(spacing:0){
            ForEach(0..<characters.count) { num in
                Text(String(self.characters[num]))
                    .offset(x: 0.0, y: offsetYForBounce)
                    .opacity(opacity)
                    .animation(.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0.1).delay( Double(num) * 0.1 ), value: offsetYForBounce)
            }
            .onTapGesture {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    opacity = 0
                    offsetYForBounce = -50
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    opacity = 1
                    offsetYForBounce = 0
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + (0.8 + baseTime)) {
                    opacity = 1
                    offsetYForBounce = 0
                }
            }
        }
    }
}


struct CalculateDrugDozeScreen: View {
    
    @State private var weight = ""
    @State private var DailyDoze = ""
    @State private var DrugDozeResult = ""

    
    
    var body: some View {
            List{
                Text(DrugDozeResult)
                    .font(.system(size: 70))
                    .frame(height: 200, alignment: .center)
                    .transition(.opacity)
                      .id("MyTitleComponent" + DrugDozeResult)
            Text("Ваш вес:")
            TextField("Введите вес в кг", text: $weight)
                       .onReceive(Just(weight)) { newValue in
                           let filtered = newValue.filter { "0123456789.".contains($0) }
                           if filtered != newValue {
                               self.weight = filtered
                           }
                       }
            Text("Назначенная суточная доза:")
            TextField("Введите суточную дозу в мг", text: $DailyDoze)
                       .onReceive(Just(DailyDoze)) { newValue in
                           let filtered = newValue.filter { "0123456789.".contains($0) }
                           if filtered != newValue {
                               self.DailyDoze = filtered
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
        withAnimation (.easeIn(duration: 1)){
            guard Double(weight) != nil  else {
                  return
                }
            var input: Double = Double(weight)!
            var logic = CalculateLogic()
            var res: Double
            res = logic.calculateFinalDoze(sut_doze:Double(DailyDoze)!, mass:input)

            DrugDozeResult = String(format: "%.2f мг", res)
        }

    }
}
