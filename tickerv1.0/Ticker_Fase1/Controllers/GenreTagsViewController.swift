//
//  GenreTagsViewController.swift
//  Ticker_Fase1
//
//  Created by Luis Fernando AG on 7/6/18.
//  Copyright © 2018 Fernando Alquicira. All rights reserved.
//

import UIKit

class GenreTagsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: FlowLayout!
    @IBOutlet weak var doneButton: UIButton!
    

    let TAGS = ["Alternativo", "Rock", "Folk", "Rock Alternativo", "Techno","Salsa","Banda","Jazz"]
    var userTags = [String]()
     var sizingCell: TagCollectionViewCell?
     var tags = [Tag]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.layer.cornerRadius = 5
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        collectionView.allowsMultipleSelection = true
        // THIS IS ALL WHAT IS REQUIRED TO SETUP YOUR TAGS
        let cellNib = UINib(nibName: "TagCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "TagCell")
        self.collectionView.backgroundColor = UIColor.clear
        self.sizingCell = (cellNib.instantiate(withOwner: nil, options: nil) as NSArray).firstObject as! TagCollectionViewCell?
        self.flowLayout.sectionInset = UIEdgeInsetsMake(20, 8, 20, 20)
        for name in TAGS{
            let tag = Tag()
            tag.name = name
            self.tags.append(tag)
        }

    }

  
    
    // MARK - COLLECTION VIEW DATA SOURCE
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCollectionViewCell
        self.configureCell(cell, forIndexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.configureCell(self.sizingCell!, forIndexPath: indexPath)
        return self.sizingCell!.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = self.collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell{

            cell.isSelected = true
            configureCell(cell, forIndexPath: indexPath)

            if let index = userTags.index(of: cell.tagLabel.text!){

                userTags.remove(at: index)

            }else{

            userTags += [cell.tagLabel.text!]
            }

        }

        for tags in userTags{
            print(tags)

        }
        if userTags.isEmpty == true{
            print("NO TAGS")
        }

    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = self.collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell{
            
            cell.isSelected = false
            configureCell(cell, forIndexPath: indexPath)
            self.collectionView.deselectItem(at: indexPath, animated: true)
            
        }
    }
    
    func configureCell(_ cell: TagCollectionViewCell, forIndexPath indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        cell.tagLabel.text = tag.name
        if cell.isSelected{
            cell.fisSelected(isSelected: true)
        }else{
            cell.fisSelected(isSelected: false)
        }
//        cell.tagLabel.textColor = tag.selected ? UIColor.white : UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
//        cell.backgroundColor = tag.selected ? .randomColors() : UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        
       
    }
    
   
}

/*
 "Alternativo", "Rock", "Folk", "Rock Alternativo", "Techno","Salsa","Banda","Jazz", "Rock Nu Disco","Electrónica","Bachata","Alternativo", "Rock", "Folk", "Rock Alternativo", "Techno","Salsa","Banda","Jazz", "Rock Nu Disco","Electrónica","Bachata","Alternativo", "Rock", "Folk", "Rock Alternativo", "Techno","Salsa","Banda","Jazz", "Rock Nu Disco","Electrónica","Bachata"
 */

