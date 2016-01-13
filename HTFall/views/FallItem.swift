//
//  FallItem.swift
//  HTFall
//
//  Created by pactera on 1/11/16.
//  Copyright © 2016 ht. All rights reserved.
//

import Foundation
import UIKit

class FallItem:UIView{
    var identifier:String?
    var nameLabel:UILabel?
    var indexItem:Int?
    init(identifier:String){
//        let frame = CGRectMake(0, 0, 300, 20);
        super.init(frame: CGRectZero)
        self.identifier = identifier
        self.backgroundColor = UIColor.redColor();
        self.setupupUI()
    }
    override init(frame: CGRect){
        super.init(frame: frame);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   //MARK: - PUBLIC METHODS 
    override func layoutSubviews() {
        self.nameLabel?.frame = CGRectMake(0, 0,50,30)
    }
    var index: Int{
        get{
            return self.indexItem!
        }
        set(newValue){
            self.indexItem = newValue
            self.nameLabel?.text = "\(newValue)"
        }
    }
    
   //MARK: - PRIVATE METHODS 
    private func setupupUI(){
        nameLabel = UILabel.init()
        nameLabel?.backgroundColor = UIColor.greenColor()
        nameLabel?.text = "NameLabel"
        self.addSubview(nameLabel!)
    }
    
    
    
    
    
    
}