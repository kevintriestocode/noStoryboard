//
//  Cell.swift
//  noStoryboard
//
//  Created by Kevin Wang on 8/1/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//
//  gist: https://gist.github.com/cs-rodrigo-cavalcante/41d87855b033a7fb861bd6fdf73eb5d6#file-cell-swift

import Foundation
import UIKit

// MARK: - Cell
/// Cell is a subclass of UITableViewCell
class Cell: UITableViewCell {
    
    //MARK: - Properties
    /// User defined properties of the `Cell` class
    let labelName: UILabel
    let labelCategory: UILabel
    let companyImage: UIImageView
    
    //MARK: - Initializer for properties
    /// Override inherited initializer from `UITableViewCell`
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.labelName = UILabel()
        self.labelCategory = UILabel()
        self.companyImage = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Methods (to be defined outside of the scope of the initializer)
        initViews()
        addViews()
        setupConstraints()
    }
    
    //MARK: - What is this?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(code:) has not been implemented")
    }
    
    //MARK: - initViews method
    func initViews() {
        labelName.textColor = .white
        labelName.font = UIFont.systemFont(ofSize: 17.0)
        
        labelCategory.textColor = .white
        labelCategory.font = UIFont.systemFont(ofSize: 13.0)
        
        companyImage.clipsToBounds = true
        companyImage.layer.borderWidth = 1.0
        companyImage.layer.borderColor = UIColor.white.cgColor
    }
    //MARK: Override super.method, layoutSubviews()
    /// layoutSubviews() is an open method of `UIView`.
    /// `Cell` subclass of `UITableView` subclass of `UIView`
    override func layoutSubviews() {
        super.layoutSubviews()
        companyImage.layer.cornerRadius = companyImage.frame.size.width / 2
    }
    
    //MARK: - addViews method
    func addViews(){
        self.addSubview(labelName)
        self.addSubview(labelCategory)
        self.addSubview(companyImage)
    }
    
    //MARK: - setupConstraints method
    func setupConstraints() {
        
    }
}
