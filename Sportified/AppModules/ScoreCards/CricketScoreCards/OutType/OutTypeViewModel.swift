//
//  OutTypeViewModel.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 03/08/2024.
//

import Foundation
class OutTypeViewModel: BaseViewModel {
    
    var coordinator: HomeCoordinator?
    
    var nearbyMatchesitem: NearbyMatchesList?
    var outTypeCallBack:((String)->Void) = {_ in}
}
