//
//  TagCollectionViewCell.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/6/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit
import Foundation

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tagNameMaxWidthConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        
        self.backgroundColor = .clear
        self.tagLabel.textColor = uicolorFromHex(rgbValue: 0xfafafa, alpha: 1.0)
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1).cgColor
        self.layer.cornerRadius = 18
        self.tagNameMaxWidthConstraint.constant = UIScreen.main.bounds.width - 8 * 2 - 8 * 2
    }
    
    func fisSelected(isSelected:Bool){
        if isSelected == true{
            self.backgroundColor = .randomColors()
           
        }else{
            self.backgroundColor = uicolorFromHex(rgbValue: 0x333346, alpha: 1.0)
        }
    }
    
    // Function to convert hex values to UICOLORE (RGB)
    func uicolorFromHex(rgbValue:UInt32, alpha: Double)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha: CGFloat(alpha))
    }
    
    
}
