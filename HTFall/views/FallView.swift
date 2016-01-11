//
//  FallView.swift
//  HTFall
//
//  Created by pactera on 1/11/16.
//  Copyright © 2016 ht. All rights reserved.
//

import Foundation
import UIKit


enum FallItemMarginType{
    case FallItemMarginTop
    case FallItemMarginRight
    case FallItemMarginBottom
    case FallItemMarginLeft
    case FallItemMarginBetCols
    case FallItemMarginBetRows
}

@objc protocol FallDataSource{
    func numbersOfCellInView(fallView: FallView) -> Int;
    func fallView(fallView: FallView, itemForRowAtIndex:Int)-> FallItem;
    optional  func numberOfColInFallView(fallView: FallView) -> Int;
    
}

protocol FallDelegate{
    func fallView(fallView: FallView,hieghtForItemAtIndex:Int)-> Float;
    func fallView(fallView: FallView,marginForType:FallItemMarginType) -> Float;
}




class FallView :UIScrollView {
    
    let screenSize = UIScreen.mainScreen().bounds.size;
    let ItemDefaultHeight: CGFloat = 30
    let ItemsDefaultMargin: CGFloat = 30
    let FallViewDefaultCols: Int  = 2
    
    //MARK: - properties
    var fallDataSource: FallDataSource?;
    var fallDelegate: FallDelegate?;
    var framsArray:[CGRect]?
    var maxYOfItem:[Float]?
    
    
    //MARK: - override methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI();
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        for (var i = 0 ; i < self.framsArray?.count ; i++){
            let frame = self.framsArray?[i];
            let item = self.fallDataSource?.fallView(self, itemForRowAtIndex: i)
            item?.frame = frame!;
            self.addSubview(item!);
        }
        
    }
   //MARK: - public methods
    func reloadData(){
        if let dataSource = fallDataSource{
            if self.framsArray == nil{
                self.framsArray = [CGRect]()
            }
            
            self.maxYOfItem = [Float](count: FallViewDefaultCols, repeatedValue: 0.0)
            
            //计算Item的margin
            let itemTopMargin = self.fallDelegate?.fallView(self, marginForType: .FallItemMarginTop)
            
            let itemLeftMargin = self.fallDelegate?.fallView(self, marginForType: .FallItemMarginLeft)
            let itemRightMargin = self.fallDelegate?.fallView(self, marginForType: .FallItemMarginRight)
            let itemBetColsMargin = self.fallDelegate?.fallView(self, marginForType: .FallItemMarginBetCols)
            let itemBetRowsMargin = self.fallDelegate?.fallView(self, marginForType: .FallItemMarginBetRows)
            let itemBottomMargin = self.fallDelegate?.fallView(self, marginForType: .FallItemMarginBottom)
            
            let marginBetCols =  Float((self.maxYOfItem?.count)! - 1)*itemBetColsMargin!
            let itemsTotalWidth = Float(screenSize.width) - itemLeftMargin! - itemRightMargin! - marginBetCols
            let itemWidth = itemsTotalWidth / Float((self.maxYOfItem?.count)!)
            
            
            let numItmds = dataSource.numbersOfCellInView(self)
            //计算frame
            
            for (var i = 0 ; i < numItmds ; i++){
                
                let itemHeight = self.fallDelegate?.fallView(self, hieghtForItemAtIndex: i);
                //计算出当前所处的列
                var tmpMaxY = self.maxYOfItem?[0]
                var currentColIndex = 0
                for(var j = 0 ; j < self.maxYOfItem?.count ; j++)
                {
                    if tmpMaxY > self.maxYOfItem?[j]{
                        tmpMaxY = self.maxYOfItem?[j]
                        currentColIndex = j
                    }
                }
               //计算item 的x 值。
                let x = itemLeftMargin! + (itemWidth + itemBetColsMargin!) * Float(currentColIndex);
                
                var y:Float
                if(tmpMaxY <= 0.0){
                    y = itemTopMargin!
                }else{
                    y = tmpMaxY! + itemBetRowsMargin!
                }
                self.maxYOfItem![currentColIndex] = y + itemHeight!
                
                let frame = CGRectMake(CGFloat(x), CGFloat(y), CGFloat(itemWidth), CGFloat(itemHeight!))
                self.framsArray?.append(frame);
            }
            //找出最下面的item 
            var maxY = self.maxYOfItem?[0]
            for(var k = 0 ; k < self.maxYOfItem?.count ; k++)
            {
                if maxY < self.maxYOfItem?[k]{
                    maxY = self.maxYOfItem![k]
                }
            }
            let fallHeight = maxY! + itemBottomMargin!
            self.contentSize = CGSizeMake(320, CGFloat(fallHeight));
        }else{
            self.contentSize = CGSizeMake(320, CGFloat(568));
        }
    }
    
   //MARK: - private methods
    private func setupUI(){
        self.backgroundColor = UIColor.blueColor();
    }
    
    
}
