//
//  NumbersCollectionView.swift
//  ViewsProgrammatically
//
//  Created by Douglas Galante on 3/23/17.
//  Copyright © 2017 Dougly. All rights reserved.
//
import UIKit

class NumbersCollectionViewDelegateAndDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let numbers: [String]
    
    override init() {
        var nums: [String] = ["A"]
        self.numbers = nums
    }
    
    // MARK: - Number Of Sections
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! NumbersCollectionViewCell
        cell.label.text = String(numbers[indexPath.row])
        return cell
    }
    
}
