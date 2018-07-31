//
//  ViewController.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 6/19/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class WelcomeController: UIViewController, UIScrollViewDelegate {
    
    /* Global Variables */
    var player: AVPlayer?
    var videoSource : String? = "tickerTrailer"
    var videoExtension : String? = "mp4"
    var originalx : Float = 0
    
    /* IBOutlets */
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var textViewInfo: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var button_createAccount: UIButton!
    @IBOutlet weak var button_login: UIButton!
    
    @IBOutlet weak var navController: UINavigationItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Call function to set UI
        fSetUI()
        
        //Call function to set Scroller
        fSetScroller()
       
        //Listener to pause video
        fAppNotActive()
       
        //Listener to render video
        let notificationCentertwo = NotificationCenter.default
        notificationCentertwo.addObserver(self, selector: #selector(appNoLongerInBackground), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
        
        //Play background video
        fBackgroundVideo()
        
        //Add black filter to video
        fAddFilterToVideo()
        
        //Save original position from TEXTVIEW
        originalx = Float(self.textViewInfo.frame.origin.x)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //Make status bar white in dark layout
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        UIApplication.shared.statusBarStyle = .lightContent

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Make status bar white in dark layout
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default

    }
    
    //Function to setup the SCROLLER
    func fSetScroller(){
        //Set the scroll view to xPostion:0 and yPosition:0 to embrace all the screen
        self.scroller.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        //Set scroll view and page control
        self.scroller.contentSize = CGSize(width:self.scroller.frame.width * 4, height:self.scroller.frame.height)
        self.scroller.delegate = self
        self.pageControl.currentPage = 0
        
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(fmoveToNextPage), userInfo: nil, repeats: true)
    }
    
    //Function to set UI and NAV-BARController and give shape to buttons
    func fSetUI(){
        //Make vavigation bar transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Make round corners in buttons
        self.button_login.layer.cornerRadius = 5
        self.button_createAccount.layer.cornerRadius = 5
        
        self.textViewInfo.textAlignment = .center

    }
    

   
}

extension WelcomeController{
    //Function to change page controller
    @objc func fmoveToNextPage (){
        
        
        //View will slide 20px up
        var yPosition = textViewInfo.frame.origin.y
        
        var height = textViewInfo.frame.size.height
        var width = textViewInfo.frame.size.width
        
        
        
        let pageWidth:CGFloat = self.scroller.frame.width
        let maxWidth:CGFloat = pageWidth * 4
        let contentOffset:CGFloat = self.scroller.contentOffset.x
        
        var slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.scroller.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scroller.frame.height), animated: true)
        
        //xPosition = textViewInfo.frame.origin.x
        
        //View will slide 20px up
        yPosition = textViewInfo.frame.origin.y
        
//        print("origin x:\(textViewInfo.frame.origin.x)")
//        print("origin y:\(textViewInfo.frame.origin.y)")
        
        height = textViewInfo.frame.size.height
        width = textViewInfo.frame.size.width
        
//        print("x:\(textViewInfo.layer.position.x)")
//        print("y:\(textViewInfo.layer.position.y)")
//
//        print("origina x 2: \(originalx)")
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.textViewInfo.frame = CGRect(x: CGFloat(self.originalx), y: yPosition, width: width, height: height)
            
        })
        
    }
    
    //Function to render video
    func fBackgroundVideo(){
        
        //Music won't stop when playing background
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        try? AVAudioSession.sharedInstance().setActive(true)
        
        // Load the video from the app bundle.
        let videoURL: NSURL = Bundle.main.url(forResource: videoSource, withExtension: videoExtension)! as NSURL
        
        player = AVPlayer(url: videoURL as URL)
        player?.actionAtItemEnd = .none
        player?.isMuted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        
        player?.play()
        
        //loop video
        NotificationCenter.default.addObserver(self, selector: #selector(loopVideo) , name: NSNotification.Name.AVPlayerItemDidPlayToEndTime , object: player?.currentItem)
    }
    
    @objc func loopVideo() {
        player?.seek(to: kCMTimeZero)
        player?.play()
    }
    
    func fAppNotActive(){
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
    }
    
    @objc func appMovedToBackground() {
        print("App moved to background!")
        
        player?.seek(to: kCMTimeZero)
    }
    
    func fAppIsActive()  {
        let notificationCentertwo = NotificationCenter.default
        notificationCentertwo.addObserver(self, selector: #selector(appNoLongerInBackground), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    @objc func appNoLongerInBackground() {
        print("App No LOnger background!")
        
        fBackgroundVideo()
    }
    
    func fAddFilterToVideo(){
        let filter = UIView()
        filter.frame = self.view.frame
        filter.backgroundColor = UIColor.black
        filter.alpha = 0.30
        self.view.addSubview(filter)
    }
    
}

private typealias ScrollView = WelcomeController
extension ScrollView
{
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView){
        
        self.textViewInfo.frame.origin.x = 400
        let yPosition = textViewInfo.frame.origin.y
        let height = textViewInfo.frame.size.height
        let width = textViewInfo.frame.size.width
//        print("original x3: \(originalx)")
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.textViewInfo.frame = CGRect(x: CGFloat(self.originalx) , y: yPosition , width: width, height: height)
            
        })
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        
        //print(Int(currentPage))
        // Change the text accordingly
        if Int(currentPage) == 0{
            textViewInfo.text = "Regístrate para obtener información de todos los eventos en tu ciudad"
        }else if Int(currentPage) == 1{
            textViewInfo.text = "I write mobile tutorials mainly targeting iOS"
        }else if Int(currentPage) == 2 {
            textViewInfo.text = "And sometimes I write games tutorials about Unity"
            
        }
        
        
    }
}



public extension UIDevice {
    
    /// pares the deveice name as the standard name
    var modelName: String {
        
        #if targetEnvironment(simulator)
        let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
        #else
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        #endif
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"

        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        default:                                        return identifier
        }
    }
    
}

