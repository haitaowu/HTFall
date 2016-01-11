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
        return 10;
    }
    func fallView(fallView: FallView, itemForRowAtIndex: Int) -> FallItem {
        return FallItem.init();
    }
    //MARK:-   fallViewDelegate methods 
    func fallView(fallView: FallView, hieghtForItemAtIndex: Int) -> Float {
        return Float(50);
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
            return Float(5)
        }
    }
}

