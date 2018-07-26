//
//  ImageView.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/3/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIImageView {
    
    func setRounded(){
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = uicolorFromHex(rgbValue: 0x2ce8cc, opacity: 100).cgColor
    }
    
    // Function to convert hex values to UICOLORE (RGB)
    func uicolorFromHex(rgbValue:UInt32, opacity: Double)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha: CGFloat(opacity / 100))
    }
    
    
}

//extension UIColor{
//
//    func colorFromHex(rgbValue:UInt32)->UIColor{
//        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
//        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
//        let blue = CGFloat(rgbValue & 0xFF)/256.0
//        return UIColor(red:red, green:green, blue:blue, alpha: 1)
//    }

extension UIColor {
    convenience init(hex: Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    convenience init(hex: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16 / Int(255.0)),
            green: CGFloat((hex & 0xFF00) >> 8 / Int (255.0)),
            blue: CGFloat((hex & 0xFF) / Int(255.0)),
            alpha: alpha)
    }
    
    class func randomColors() -> UIColor{
        
        let randomNumber = arc4random_uniform(5)
        
        switch randomNumber {
        case 0:
            //vibrant red
            return UIColor().uicolorFromHexx(rgbValue: 0xeff101f, alpha: 1.0)
        case 1:
            //vibran blue
            return UIColor().uicolorFromHexx(rgbValue: 0x3772ff , alpha: 1.0)
        case 2:
            //vibrant pink
            return UIColor().uicolorFromHexx(rgbValue: 0xff0054, alpha: 1.0)
        case 3:
            //vibrant orange
            return UIColor().uicolorFromHexx(rgbValue: 0xff5400, alpha: 1.0)
        default:
            //vibrant green
            return UIColor().uicolorFromHexx(rgbValue: 0x04e762, alpha: 1.0)
        }
        
        
    }
    
    // Function to convert hex values to UICOLORE (RGB)
    func uicolorFromHexx(rgbValue:UInt32, alpha: Double)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha: CGFloat(alpha))
    }
}




@IBDesignable
class DesignableTextField: UITextField {
}

@IBDesignable
class DesignableView: UIView {
}


@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableTable: UITableView {
    
}
@IBDesignable
class DesignableTableCell: UITableViewCell {
    
}


extension UIView {
    
    @IBInspectable
    var maskToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
}


