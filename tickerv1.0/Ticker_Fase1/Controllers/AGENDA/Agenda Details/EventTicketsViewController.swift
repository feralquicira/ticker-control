//
//  EventTicketsViewController.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 8/1/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit

class EventTicketsViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var venueInfoImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let image = UIImage(named: "palacio"){
        let ratio = image.size.width / image.size.height
        let newHeight = venueInfoImage.frame.width / ratio
        heightConstraint.constant = newHeight
        view.layoutIfNeeded()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
