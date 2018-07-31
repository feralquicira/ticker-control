//
//  AgendaTableViewCell.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/16/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName_label: UILabel!
    @IBOutlet weak var eventPriceTag_label: UILabel!
    @IBOutlet weak var eventVenue_label: UILabel!
    @IBOutlet weak var eventDate_label: UILabel!
    @IBOutlet weak var bookMarkButton: UIImageView!
    
    
    func setUpCell(eventImage:String, eventName:String, eventPrice:String, eventVenue:String, eventDate:String){
        self.eventImage.image = UIImage(named: eventImage)
        eventName_label.text = eventName
        eventPriceTag_label.text = eventPrice
        eventVenue_label.text = eventVenue
        eventDate_label.text = eventDate
        
        let origImage = UIImage(named: "bookmark")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        bookMarkButton.image = tintedImage
        bookMarkButton.tintColor = UIColor().uicolorFromHexx(rgbValue: 0x2CE8CC, alpha: 1.0)
        
        
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
