//
//  calculateLogic.swift
//  kurs_project
//
//  Created by user on 15/12/2022.
//

import Foundation

class CalculateLogic{
    func calculateXEdoze(xe: Double, sut_doze: Double, mass: Double) -> Double{
       return xe * 1.75 * sut_doze / mass
    }
    func calculateCorrectiomDoze(delta: Double,sut_doze: Double) -> Double{
        return delta * 80/sut_doze
    }
    func calculateFinalDoze(
        sut_doze: Double, mass: Double
    )->Double{
        var db = DBViewModel()
        db.fetchData()
        var res: Double
        var last_value: Double, delta: Double
        var xe_notes = NoteViewModel()
        xe_notes.fetchData()
        var last_xe = xe_notes.notes[0].xe_record
        
        last_value = Double(db.cards[0].value)!
        delta = last_value - 7.0
        
        res = calculateXEdoze(xe: last_xe, sut_doze: sut_doze, mass: mass)
        if (delta>0){
            res += calculateCorrectiomDoze(delta: delta, sut_doze: sut_doze)
        }
        return res
    }
}
