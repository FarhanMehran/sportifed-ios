//
//  BaseData.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 09/07/2024.
//

import Combine
import Foundation

class BaseData: ObservableObject {
    
    static let shared = BaseData()
    
    @Published var matchesList:[NearbyMatchesList] = []
    @Published var temmatchesList:[NearbyMatchesList] = []
    @Published  var favoriteSportsList:[Sport]?
    @Published  var hidebar:Bool = false
}
