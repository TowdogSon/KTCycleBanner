//
//  KTBanner.swift
//  CycleBanner
//
//  Created by tuikai on 2017/7/24.
//  Copyright © 2017年 tuikai. All rights reserved.
//

import UIKit
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
let Kcell    = "bannerCell"

class KTBanner: UIView {

    //声明属性
    var timer:Timer!
    var currentIndex:Int!
    var imageNames:[String]!
    var totalCount:Int!
    //getter方法
    var _timeInterval :TimeInterval=2
    var timeInterval:TimeInterval{
        
        get{
            return _timeInterval
            
        } set (newValue) {
                _timeInterval = newValue
        }
        
    }
    //懒加载
    lazy var collectionView : UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize=CGSize(width:self.bounds.width, height: self.bounds.height)
        layout.minimumLineSpacing=0;
        layout.scrollDirection=UICollectionViewScrollDirection.horizontal
        let collectView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectView.backgroundColor = UIColor.white
        collectView.delegate=self
        collectView.dataSource=self
        collectView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Kcell)

        return collectView
    }()

    //构造方法
    init(frame: CGRect, imageNames:[String],timeInterVal:TimeInterval) {
        super.init(frame: frame)
        self.imageNames=imageNames
        totalCount=imageNames.count*10;
        timeInterval=timeInterVal
        setUp()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
              fatalError("init(coder:) has not been implemented")
    }
}

//扩展
extension KTBanner:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func setUp(){
        addSubview(collectionView)
        currentIndex=0
        timer = Timer.scheduledTimer(withTimeInterval:TimeInterval(timeInterval), repeats: true, block: { (timer) in
            self.scrollToNext()
        })
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Kcell, for: indexPath) as!BannerCollectionViewCell
    
        let i = indexPath.row%self.imageNames.count
        cell.image.image=UIImage(named: self.imageNames[i])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalCount
    }
    
   
}

extension KTBanner{
    
 
    func scrollToNext() -> Void {
        if currentIndex+1>=totalCount {
            
            // lastIndex turn to middleIndex
            
            currentIndex=totalCount/2
            let indexpath = IndexPath(row: currentIndex, section: 0)
            collectionView.scrollToItem(at:indexpath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
            return
        }
       let indexpath = IndexPath(row: currentIndex+1, section: 0)
       collectionView.scrollToItem(at:indexpath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
       currentIndex=currentIndex+1;
        
    }

}



