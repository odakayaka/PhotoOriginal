//
//  ViewController.swift
//  PhotoOriginal
//
//  Created by 尾高文香 on 2016/06/11.
//  Copyright © 2016年 com.odakaayaka. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var photoAssets = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getAllPhotosInfo()
    }
    
    /*
    private func reload() {
        getAllPhotosInfo()
        
        collectionView.reloadData()
    }
 */
   
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAssets.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        
        let asset = photoAssets[indexPath.row]
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        let manager: PHImageManager = PHImageManager()
        manager.requestImageForAsset(asset, targetSize: imageView.frame.size, contentMode: .AspectFill, options: nil) { (image, info) -> Void in
            imageView.image = image
        }
        
        return cell
    }
    
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = view.frame.width / 3 - 2//3列にするから3で割る
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }

    
    
    // MARK: Photos Framework
    
    private func getAllPhotosInfo() {
        photoAssets = []
        
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        
        let assets: PHFetchResult = PHAsset.fetchAssetsWithMediaType(.Image, options: options)
        assets.enumerateObjectsUsingBlock { (asset, index, stop) -> Void in
            self.photoAssets.append(asset as! PHAsset)
        }
        print(photoAssets)
    }
    
    /*
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 要素数を入れる、要素以上の数字を入れると表示でエラーとなる
        return 20;
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

