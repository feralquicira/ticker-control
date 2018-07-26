//
//  Event.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/17/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import Foundation
import UIKit

class Event {
    
    var name : String
    var photo : String
    var date : String
    var price: String
    var venue : String
    
    init(name: String, photo:String, date: String, price: String, venue:String) {
        self.name = name
        self.photo = photo
        self.date = date
        self.price = price
        self.venue = venue
    }
}
