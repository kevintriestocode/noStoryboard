//
//  ViewController.swift
//  noStoryboard
//
//  Created by Kevin Wang on 7/27/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//

import UIKit
import Foundation
import SnapKit


class ViewController: UIViewController {
    
    var screen: UIView!
    var centerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen = UIView()
        centerLabel = UILabel()
        
        view.addSubview(screen)
        screen.addSubview(centerLabel)
        
        screen.backgroundColor = .white
        screen.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.right.equalTo(view)
            make.left.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        centerLabel.text = "I hope I'm centered."
        centerLabel.snp.makeConstraints { (make) in
            make.center.equalTo(screen)
        }
    }
    
}
