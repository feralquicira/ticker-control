//
//  EventDetails.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/30/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit
import Cosmos
import GoogleMaps
import GooglePlaces

protocol changeConstraint {
    func moveUp(up:Bool)
}

class EventDetails: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var sinopsisTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var headphonesimage: UIImageView!
    @IBOutlet weak var mapView: GMSMapView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    // we set a variable to hold the contentOffSet before scroll view scrolls
    var lastContentOffset: CGFloat = 0
    var delegate: changeConstraint?
    
    
    var relatedArtistArray = [UIImage(named: "dorian"),UIImage(named: "dorian"),UIImage(named: "dorian"),UIImage(named: "dorian"),UIImage(named: "dorian")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupIcons(image_name: "headphones", image_view: headphonesimage, hexColor: 0x2CE8CC)

        // Setup map view
        let camera = GMSCameraPosition.camera(withLatitude: 37.36, longitude: -122.0, zoom: 14.0)
        mapView.camera = camera
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.tiltGestures = true
        mapView.settings.rotateGestures = false
        
        showMarker(position: camera.target)
        
    }
    
    // MARK: - Google Maps
    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Palacio de los Deportes"
        marker.snippet = "CDMX"
        marker.map = mapView
    }
    
    
    // MARK: - UICollection View Related Artist
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedArtistArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customRelatedArtistCell", for: indexPath) as! RelatedArtistCell
        
        cell.artistImage.image = relatedArtistArray[indexPath.row]
        cell.artistName_label.text = "The Artist Name"
        
        
        
        return cell
    }
    
    
    
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // self.lastContentOffset = scrollView.contentOffset.y
    }
    
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if self.scrollView.contentOffset.y < 0{
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
        
        if (self.scrollView.contentOffset.y > 90) {
            print("up")
            // moved to top
            delegate?.moveUp(up: true)
            self.sinopsisTopConstrain.constant = 100
            
            
        } else if (self.scrollView.contentOffset.y < 5 ) {
            // moved to bottom
            delegate?.moveUp(up: false)
            print("down")
            self.sinopsisTopConstrain.constant = 0
        }
    }
    
    
    
    
    // Function to setup ICONS COLORS
    func setupIcons(image_name: String, image_view: UIImageView, hexColor: UInt32 ){
        
        let originalIcon = UIImage(named: image_name)
        let tintedImage = originalIcon?.withRenderingMode(.alwaysTemplate)
        image_view.image = tintedImage
        image_view.tintColor = UIColor().uicolorFromHexx(rgbValue: hexColor, alpha: 1.0)
        image_view.backgroundColor = .clear
        
        
    }
    
    
    
    
}

extension EventDetails: GMSMapViewDelegate{
    
}




