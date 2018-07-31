//
//  CreateAccountController.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 6/27/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FacebookShare


class CreateAccountController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //IBOutlet
    @IBOutlet weak var fbButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var textFIeld_email : UITextField!
    @IBOutlet weak var textFIeld_password : UITextField!
    @IBOutlet weak var textFIeld_username: UITextField!
    @IBOutlet weak var textFIeld_birthDate : UITextField!
    @IBOutlet weak var textFIeldGender : UITextField!
    
    let birthPicker = UIDatePicker()
    let pickerGenderData : [String] = ["Hombre","Mujer","Otro"]
    var textFIeldCollection :[UITextField?] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFIeldCollection = [textFIeld_birthDate,textFIeld_password,textFIeldGender,textFIeld_email,textFIeld_username]
        
        //GIve shape to continue Button
        continueButton.layer.cornerRadius = 5
        
        //Call function to set UI
        fsetNavigationBar()
        fSetFacebookButton()
        fSetTextviews()
        
        //Dismiss keyboard when tap
        self.hideKeyboardWhenTappedAround()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //Make status bar white in dark layout
        UIApplication.shared.statusBarStyle = .lightContent
        
        
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //Make status bar white in dark layout
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
    }
    
    
    
    /*
     // MARK: - FACEBOOK
     Falta conectar base datos y extraer informacion del usuario a un diccionario
     
     */
    
    
    
    //Function to setup Facebook button
    func fSetFacebookButton(){
        
        //let myLoginButton = UIButton(type: .custom)
        
        fbButton.backgroundColor = uicolorFromHex(rgbValue: 0x3b5998, alpha: 1.0)
        //myLoginButton.frame = CGRect(x: 0, y: 0, width: 260, height: 40)
        //myLoginButton.center = CGPoint(x: self.view.layer.frame.width/2, y: 120)
        fbButton.setTitle("Regístrate con Facebook", for: .normal)
        fbButton.titleLabel?.font = UIFont(name: "FuturaPT-Book", size: 20)
        fbButton.layer.cornerRadius = 5
        fbButton.titleLabel?.textAlignment = .center
        // Handle clicks on the button
        fbButton.addTarget(self, action: #selector(fLoginWithFacebook), for: .touchUpInside)
        
        //view.addSubview(myLoginButton)
        
    }
    
    //FUnction to login with Facebook
    @objc func fLoginWithFacebook(){
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .email, .userBirthday, .userGender, ], viewController: self) { loginResult in
            switch loginResult{
            case .success(_,_, let token):
                self.getUserDataFromFacebook(accessToken: token)
                print("Logged in!")
            case .cancelled:
                print("User cancelled login")
            case .failed(let error):
                print(error)
            }
        }
        
    }
    
    //Function to get user data
    func getUserDataFromFacebook(accessToken: AccessToken){
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, gender"], accessToken: accessToken, httpMethod: .GET, apiVersion: .defaultVersion)
        
        graphRequest.start { (response, result) in
            
            print(result)
            
        }
    }
    
    
    
    // MARK: - NAVIGATION BAR
    
    
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
    
    
    // MARK: - TOOL BAR
    
    
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
    
    func fAddToolBarBirthPicker(textField:UITextField){
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textField.frame.size.width, height: 30))
        //Create left side empty space so the donde button is on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton: UIBarButtonItem = UIBarButtonItem(title: "Hecho", style: .done, target: self, action: #selector(writeDate))
        toolbar.setItems([flexSpace, doneButton], animated: false)
        toolbar.sizeToFit()
        
        //Add toolbar
        textField.inputAccessoryView = toolbar
    }
    
    
    
    
    
    
    // MARK: UIPickerView Delegation
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerGenderData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerGenderData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        textFIeldGender.text = pickerGenderData[row]
        
    }
    
    //FUnction to bring Picker when touching sex textField
    func fBringGenderPicker(textField: UITextField){
        let sexPicker = UIPickerView()
        sexPicker.tag = 1
        sexPicker.delegate = self
        textField.inputView = sexPicker
        
    }
    
    // Function to bring age Picker when touching birth date textField
    func fBringBirthPicker(textField: UITextField){
        birthPicker.datePickerMode = .date
        birthPicker.tag = 2
        textField.inputView = birthPicker
        
        
    }
    
    @objc func writeDate(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        textFIeld_birthDate.text = formatter.string(from: birthPicker.date)
        self.view.endEditing(true)
        
    }
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - TEXT FIELDS
     
     */
    
    //Function to set placeholders ui
    func fSetTextviews(){
        
        for textField in textFIeldCollection{
            
            setTextfield(textField: textField!)
            textField?.autocorrectionType = .no
        }
        
        
        // Add picker here
        fBringBirthPicker(textField: textFIeld_birthDate)
        // Add tool bar
        fAddToolBarBirthPicker(textField: textFIeld_birthDate)
        
        
        
        //Bring Picker
        fBringGenderPicker(textField: textFIeldGender)
        //Add Tool Bar
        fAddToolBar(textField: textFIeldGender)
        
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
    
}




