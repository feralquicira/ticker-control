//
//  MasterDetails.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/30/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit


class MasterDetails:UIViewController, changeConstraint {
    
    func moveUp(up: Bool) {
        
        
        if up{
            
            self.yConstraintSegmentedControl.constant = 50
            self.imageHeightConstrain.constant = 0
            self.moveIconsToLeft(views: [self.markerImage, self.calendarImage, self.moneyImage, self.closeImage, self.eventName_label, self.eventVenue_label, self.eventDate_label, self.eventRangePrice_label])
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                
            }
        }
        
        else{
            self.yConstraintSegmentedControl.constant = 30
            self.imageHeightConstrain.constant = 300
            
            UIView.animate(withDuration: 0.3) {
                self.segmentedControl.alpha = 1
                self.segmentedControl.isEnabled = true
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    @IBOutlet weak var markerImage : UIImageView!
    @IBOutlet weak var calendarImage : UIImageView!
    @IBOutlet weak var moneyImage : UIImageView!
    @IBOutlet weak var closeImage: UIImageView!
    @IBOutlet weak var headphonesImage: UIImageView!
    @IBOutlet weak var eventName_label: UILabel!
    @IBOutlet weak var eventVenue_label: UILabel!
    @IBOutlet weak var eventDate_label: UILabel!
    @IBOutlet weak var eventRangePrice_label: UILabel!
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var ticketsView: UIView!
    
    
    
    @IBOutlet weak var imageCanvas: DesignableView!
    
    
    @IBOutlet weak var segmentedControl: RoundSegmentedControl!
    @IBOutlet weak var yConstraintSegmentedControl: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var firstView: UIView!
    
    var xPosition: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //Make status bar white in dark layout
        UIApplication.shared.statusBarStyle = .lightContent
        // Setup icons
        setupIcons(image_name: "marker", image_view: markerImage, hexColor: 0x2CE8CC)
        setupIcons(image_name: "calendar", image_view: calendarImage, hexColor: 0x2CE8CC)
        setupIcons(image_name: "money", image_view: moneyImage, hexColor: 0x2CE8CC)
        setupIcons(image_name: "close", image_view: closeImage, hexColor: 0xfafafa)
        
        let arrayOfIcons : [UIImageView] = [markerImage,calendarImage,moneyImage,closeImage]
        
        //Set CLOSE ICON
        closeScreenWhenTapClose(icon: closeImage)
        xPosition = markerImage.frame.origin.y
        saveOriginalXPosition(images: arrayOfIcons)
        
    }
    
    @IBAction func switchViews(_ sender: RoundSegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            detailsView.isHidden = false
            ticketsView.isHidden = true
        default:
            ticketsView.isHidden = false
            detailsView.isHidden = true
        }
    }
    
    
    
    
    // Function to close screen when touching close ICON
    
    func closeScreenWhenTapClose(icon: UIImageView){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMe))
        icon.addGestureRecognizer(tap)
        icon.isUserInteractionEnabled = true
    }
    @objc func tappedMe(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    // Function to setup ICONS COLORS
    func setupIcons(image_name: String, image_view: UIImageView, hexColor: UInt32 ){
        
        let originalIcon = UIImage(named: image_name)
        let tintedImage = originalIcon?.withRenderingMode(.alwaysTemplate)
        image_view.image = tintedImage
        image_view.tintColor = UIColor().uicolorFromHexx(rgbValue: hexColor, alpha: 1.0)
        image_view.backgroundColor = .clear
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstViewIdentifier"{
            let dvc = segue.destination as! EventDetails
            dvc.delegate = self
        }
    }
    
    func saveOriginalXPosition(images: [UIImageView]){
        
        
        for imagen in images{
            imagen.frame.origin.x = self.xPosition
            
        }
    }
    
    func moveIconsToLeft(views: [UIView]){
        let newXPosition = -300
        for img in views{
            img.frame = CGRect(x: CGFloat(newXPosition), y: img.frame.origin.y, width: img.frame.width, height: img.frame.height)
        }
    }
}

