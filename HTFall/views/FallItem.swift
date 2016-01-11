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
    
     init(){
        let frame = CGRectMake(0, 0, 300, 20);
        super.init(frame: frame)
        self.backgroundColor = UIColor.redColor();
    }
    override init(frame: CGRect){
        super.init(frame: frame);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}