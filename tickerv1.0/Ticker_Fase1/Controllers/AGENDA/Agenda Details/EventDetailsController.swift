//
//  EventDetailsController.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/24/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit

class EventDetailsController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var markerImage : UIImageView!
    @IBOutlet weak var calendarImage : UIImageView!
    @IBOutlet weak var moneyImage : UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var closeImage: UIImageView!
    
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Make status bar white in dark layout
        UIApplication.shared.statusBarStyle = .lightContent
        self.scrollView.delegate = self
        // Setup icons
        setupIcons(image_name: "marker", image_view: markerImage, hexColor: 0x2CE8CC)
        setupIcons(image_name: "calendar", image_view: calendarImage, hexColor: 0x2CE8CC)
        setupIcons(image_name: "money", image_view: moneyImage, hexColor: 0x2CE8CC)
        setupIcons(image_name: "close", image_view: closeImage, hexColor: 0xfafafa)
        
        //Set CLOSE ICON
        closeScreenWhenTapClose(icon: closeImage)
        
        
        
    }
    
    
    
    
    @IBAction func switchViews(_ sender: RoundSegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            firstView.isHidden = false
            secondView.isHidden = true
            print("first view")
        default:
            secondView.isHidden = false
            firstView.isHidden = true
            print("second view")
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

   
    
    
    
    
    
    //Function to limit Offser of the scroll view
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0{
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
