//
//  ViewController.swift
//  HTFall
//
//  Created by pactera on 1/11/16.
//  Copyright © 2016 ht. All rights reserved.
//

import UIKit

class ViewController: UIViewController,FallDataSource,FallDelegate{
    let screenSize = UIScreen.mainScreen().bounds.size;
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 20, width:screenSize.width, height: screenSize.height - 20);
        let fallView: FallView = FallView.init(frame: frame);
        self.view.addSubview(fallView);
        fallView.fallDataSource = self;
        fallView.fallDelegate = self;
        fallView.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:-   fallViewDataSource
     func numbersOfCellInView(fallView: FallView) -> Int {
        return 20;
    }
    func fallView(fallView: FallView, itemForRowAtIndex index: Int) -> FallItem {
        var item = fallView.dequeueReuseCellWithIdentifier("CellIdetifier", index: index)
        if (item == nil){
            item = FallItem.init()
            item?.identifier = "CellIdetifier"
        }
        return item!
    }
    //MARK:-   fallViewDelegate methods 
    func fallView(fallView: FallView, heightForItemAtIndex index: Int) -> Float {
        switch (index % 5){
        case 0:return Float(110)
        case 2:return Float(90)
        case 1:return Float(140)
        case 3:return Float(80)
        default: return Float(45);
        }
    }
    
    
    func fallView(fallView: FallView, marginForType: FallItemMarginType) -> Float {
        switch marginForType{
        case .FallItemMarginTop,.FallItemMarginBottom:
            return Float(10)
        case .FallItemMarginRight,.FallItemMarginLeft:
            return Float(10)
        case .FallItemMarginBetCols:
            return Float(10)
        case .FallItemMarginBetRows:
            return Float(15)
        }
    }
}

