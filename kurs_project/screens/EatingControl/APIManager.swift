//
//  APIManager.swift
//  kurs_project
//
//  Created by user on 15/12/2022.
//

import Foundation
import Alamofire
import SwiftyJSON


final class ApiManager: ObservableObject{
    
    @Published var data: Array<JsonItem> = []
    
    func get_data(){
        let url = "https://virtserver.swaggerhub.com/OS01GLADOS/bread_number/1.0.0/"
        AF.request(url).responseDecodable(of: [JsonItem].self){ response in
            self.data = try! response.result.get()
        }
    }
}

