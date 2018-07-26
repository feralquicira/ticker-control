//
//  CreateAccountSecondViewController.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/3/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit

class CreateAccountSecondViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //IBOUTLeTS
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var usernameTextField : UITextField!
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var lastnameTextField : UITextField!
    @IBOutlet weak var continueButton : UIButton!
    @IBOutlet weak var nationalityTextfield: UITextField!
    
    //Global Variables
    var imagePicker = UIImagePickerController()
    let countries = NSLocale.isoCountryCodes.map { (code:String) -> String in
        let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return NSLocale(localeIdentifier: "es_MX").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Set delegate to imagePicker
        imagePicker.delegate = self
        // Add gesture to image
        addGestureToImage(profilePicture: profilePicture)
        // Set UI for navigation bar
        fsetNavigationBar()
        // Set UI for Outlets
        fSetOutletsUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - UI FOR OUTLETS
    func fSetOutletsUI(){
        // Give circular shape to Profile Picture
        profilePicture.setRounded()
        // Set the texfields
        setTextfield(textField: self.usernameTextField)
        setTextfield(textField: self.nameTextField)
        setTextfield(textField: self.lastnameTextField)
        setTextfield(textField: self.nationalityTextfield)
        
        //Add picker to nationality text field
        fBringCountriesPicker(textField: self.nationalityTextfield)
        // Add toolbar to text field
        fAddToolBar(textField: self.nationalityTextfield)
        
        
    }
    
    
    
    
    // MARK - UIPciker Delegation
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return countries.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        nationalityTextfield.text = countries[row]
        
    }
    
    // Function to bring Picker when touching textfield
    func fBringCountriesPicker(textField:UITextField){
        let countryPicker = UIPickerView()
        countryPicker.delegate = self
        textField.inputView = countryPicker
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK - UIIMAGE FUNCTIONALITY
    func addGestureToImage(profilePicture : UIImageView){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture))
        profilePicture.isUserInteractionEnabled = true
        profilePicture.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapGesture(){
        let alert:UIAlertController=UIAlertController(title: "Profile Picture Options", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let gallaryAction = UIAlertAction(title: "Open Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in self.openGallary()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in self.cancel()
            
        }
        
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openGallary()
    {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func cancel(){
        print("Cancel Clicked")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        profilePicture.contentMode = .scaleAspectFit
        profilePicture.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK - NAVIGATION BAR
    /*
     Keep same UI and Format in the navigation bar
     */
    
    //Function to set UI -> Just NAV BAR & TITLE
    func fsetNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        self.navigationItem.title = "Regístrate"
        
        let navigationBarAppearace = self.navigationController?.navigationBar
        navigationBarAppearace?.tintColor = uicolorFromHex(rgbValue: 0xfafafa, alpha: 1.0)
        navigationBarAppearace?.barTintColor = uicolorFromHex(rgbValue: 0x5f5e80, alpha: 1.0)
        // change navigation item title color
        navigationBarAppearace?.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, NSAttributedStringKey.font: UIFont(name: "FuturaPT-Book", size: 20)!]
        
        
    }
    
    
    
    
    
    // Function to move to next text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag){
            nextResponder.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    
    
    // Function to give UI to Text fields
    func setTextfield(textField: UITextField){
        
        textField.attributedPlaceholder = NSAttributedString(string: (textField.placeholder?.description)!,
            attributes: [NSAttributedStringKey.foregroundColor: uicolorFromHex(rgbValue: 0xfafafa, alpha: 0.5)])
        textField.layer.cornerRadius = 5
        textField.delegate = self
        
        
    }
    
    // Function to convert hex values to UICOLORE (RGB)
    func uicolorFromHex(rgbValue:UInt32, alpha: Double)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha: CGFloat(alpha))
    }
    
    
    // MARK - Tool Bar options
    //Init toolbar to add to numeric textfield and Picker
    
    func fAddToolBar(textField: UITextField){
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 30))
        //Create left side empty space so the donde button is on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Hecho", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.setItems([flexSpace, doneButton], animated: false)
        toolbar.sizeToFit()
        
        //Add toolbar
        textField.inputAccessoryView = toolbar
    }

}


