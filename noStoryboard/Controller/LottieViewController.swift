//
//  LottieViewController.swift
//  noStoryboard
//
//  Created by Kevin Wang on 11/8/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//

import Foundation
import SnapKit
import Lottie

class LottieViewController: UIViewController {
  var lottieFile = LOTAnimationView(name: "data", bundle: Bundle.main)
  var backButton: UIButton!

  let buttonSize = 80
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white

    backButton = UIButton()
    backButton.addTarget(self, action: #selector(back), for: .touchUpInside)

    backButton.setTitle("Back", for: .normal)

    backButton.titleLabel?.textColor = .black
    backButton.backgroundColor = .gray
    backButton.layer.cornerRadius = CGFloat(buttonSize / 2)

    view.addSubview(backButton)
    backButton.snp.makeConstraints { make in
      make.left.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      make.size.equalTo(buttonSize)
    }
  }

  @objc func back() {
    navigationController?.popViewController(animated: true)
  }
}
