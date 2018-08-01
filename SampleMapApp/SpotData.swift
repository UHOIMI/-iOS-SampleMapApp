//
//  SpotData.swift
//  SampleMapApp
//
//  Created by 猪岡勝生 on 2018/07/20.
//  Copyright © 2018年 Swift-Biginners. All rights reserved.
//

import UIKit
import CoreLocation

class SpotData: NSObject {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var name: String
    var date: Date

    override init() {
        latitude = 0.0
        longitude = 0.0
        name = "未入力"
        date = Date()
    }
    
    init(la : CLLocationDegrees, lo : CLLocationDegrees , na : String) {
        latitude = la
        longitude = lo
        name = na
        date = Date()
    }
}
