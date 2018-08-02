//
//  ViewController.swift
//  noStoryboard
//
//  Created by Kevin Wang on 7/27/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//
//  Copied from @Dougly

import UIKit
import Foundation
import SnapKit


class ViewController: UIViewController {

    //MARK: - Declare view controller's properties: of type
    var headerView: UIView!
    var titleLabel: UILabel!
    var numbersCollectionView: UICollectionView!
    let numbersCollectionViewDelegateAndDataSource = NumbersCollectionViewDelegateAndDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderAndTitleLabel()
        
        let frame = self.view.frame
        //MARK: - SNAPKIT
        self.view.snp.makeConstraints {(make) in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        //MARK: - layout is an instance of UICollectionViewFlowLayout()
        let layout = UICollectionViewFlowLayout()
        
        //MARK: - numbersCollectionView is an instance of UICollection
        numbersCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.view.addSubview(numbersCollectionView)
        
        
        numbersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        numbersCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        numbersCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        numbersCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        numbersCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        
        
        numbersCollectionView.register(NumbersCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        numbersCollectionView.delegate = numbersCollectionViewDelegateAndDataSource
        numbersCollectionView.dataSource = numbersCollectionViewDelegateAndDataSource
    }
    
    
    func setupHeaderAndTitleLabel() {
        // Initialize views and add them to the ViewController's view
        headerView = UIView()
        headerView.backgroundColor = .white
        self.view.addSubview(headerView)
        
        titleLabel = UILabel()
        titleLabel.text = "\(Date())"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 14)
        headerView.addSubview(titleLabel)
        
        // Set position of views using constraints
        headerView.snp.makeConstraints { (make) in
            make.width.equalTo(view)
        }
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.4).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
}
