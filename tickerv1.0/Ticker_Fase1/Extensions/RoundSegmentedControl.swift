//
//  RoundSegmentedControl.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/24/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit

@IBDesignable
class RoundSegmentedControl: UIControl {
    
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = ""{
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textColor: UIColor = UIColor().uicolorFromHexx(rgbValue: 0x333346, alpha: 1.0){
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = UIColor().uicolorFromHexx(rgbValue: 0x333346, alpha: 1.0){
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = UIColor().uicolorFromHexx(rgbValue: 0xfafafa, alpha: 1.0){
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        buttons.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for buttontTitle in buttonTitles{
            let button = UIButton(type: .system)
            button.setTitle(buttontTitle, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.layer.cornerRadius = frame.height / 2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    
   @objc func buttonTapped(button: UIButton){
        for (index,btn) in buttons.enumerated(){
            btn.setTitleColor(textColor, for: .normal)
            
            if btn == button{
                selectedSegmentIndex = index
                UIView.animate(withDuration: 0.3) {
                    let selectorStartPosition = self.frame.width/CGFloat(self.buttons.count) * CGFloat(index)
                    self.selector.frame.origin.x = selectorStartPosition
                }
            }
            
            if btn == button{
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
    
    sendActions(for: .valueChanged)
    }

}
