//
//  MapTasks.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/31/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import Foundation
import UIKit

class MapTasks: NSObject{
    
    let baseURLGeocode = "https://maps.googleapis.com/maps/api/geocode/json?"
    
    var lookupAddressResults: Dictionary<NSObject, AnyObject>!
    
    var fetchedFormattedAddress: String!
    
    var fetchedAddressLongitude: Double!
    
    var fetchedAddressLatitude: Double!
    
    override init() {
        super.init()
    }
    
//    func geocodeAddress(address: String!, withCompletionHandler completionHandler: @escaping ((_ status: String, _ success: Bool) -> Void)) {
//        
//        if let lookUpAddress = address{
//            var geocodeURLString = baseURLGeocode + "address=" + lookUpAddress
//            geocodeURLString = geocodeURLString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
//            let geocodeURL = NSURL(string: geocodeURLString)
//            
//            DispatchQueue.main.async {
//                let geocodingResultsData = NSData(contentsOf: geocodeURL! as URL)
//                
////                var error: NSError?
////                let dictionary: Dictionary<NSObject, AnyObject>
////
//                do{
//                    
////                    dictionary = try JSONSerialization.jsonObject(with: geocodingResultsData! as Data, options: .mutableContainers) as! Dictionary<NSObject, AnyObject>
//                    
//                    // Get response status
//                    
//                    // TO-DO
//            
//                    
//                } catch{
//                    
//                }
//                
//            }
//            
//        }
//        
//    }
    
    
}
