//
//  LoopBannerView.swift
//  LoopBannerView
//
//  Created by Pro on 2016/12/17.
//  Copyright © 2016年 LittleMatt. All rights reserved.
//

import UIKit

class LoopBannerView: UIView , UICollectionViewDelegate, UICollectionViewDataSource ,UIScrollViewDelegate{
    
    let kHeight = UIScreen.main.bounds.size.height
    let kWidth = UIScreen.main.bounds.size.width

    var collection: UICollectionView!
    var pageControl: UIPageControl!
    var currentPage = 1 //第几页，从1开始算
    
    var imagesArray = ["4.jpg","1.jpg","2.jpg","3.jpg","4.jpg","1.jpg"]
    var timer :Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews () {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.itemSize = CGSize(width:kWidth, height:self.bounds.size.height)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        collection = UICollectionView.init(frame: self.bounds, collectionViewLayout: flowLayout)
        collection.backgroundColor = UIColor.white
        
        collection.register(UINib(nibName: "GuideViewCell", bundle: nil), forCellWithReuseIdentifier: "GuideViewCell")
        collection.delegate = self
        collection.dataSource = self
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        self.addSubview(collection)
        
        pageControl = UIPageControl.init(frame: CGRect(x:0, y:self.bounds.size.height-20, width:kWidth, height:20)) as  UIPageControl
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = imagesArray.count-2
        self.addSubview(pageControl)
        
        collection.reloadData()
        collection.setContentOffset(CGPoint(x:kWidth, y:0), animated: false)
        
        addTimer()
    }
    
    func addTimer () {
        let tm = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        RunLoop.current.add(tm, forMode: RunLoopMode.commonModes)
        timer = tm
    }
    
    func removeTimer () {
        timer?.invalidate()
        timer = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GuideViewCell", for: indexPath) as! GuideViewCell
        cell.imageName = imagesArray[indexPath.row]
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / kWidth
        currentPage = Int(page)
        pageControl.currentPage  = Int(page) - 1
        
        if currentPage == 0 {
        pageControl.currentPage = imagesArray.count - 1
        scrollView.setContentOffset(CGPoint(x:CGFloat((imagesArray.count-2))*kWidth, y:0), animated: false)
        }
        if currentPage == imagesArray.count - 1 {
            pageControl.currentPage = 0
            scrollView.setContentOffset(CGPoint(x:kWidth, y:0), animated: false)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / kWidth
        currentPage = Int(page)
    }
    
    func nextPage() {
        currentPage += 1
        collection.setContentOffset(CGPoint(x:CGFloat(currentPage)*kWidth, y:0), animated: true)
        if currentPage == imagesArray.count - 1   {
            currentPage = 1
            collection.setContentOffset(CGPoint(x:kWidth, y:0), animated: true)
        }
        if currentPage < imagesArray.count - 1 {
            pageControl.currentPage = currentPage - 1
        }
    }
}
