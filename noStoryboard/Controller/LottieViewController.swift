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
  var lottieAnimation = LOTAnimationView(name: "data", bundle: Bundle.main)
  var backButton: UIButton!

  let buttonSize = 80
  override func viewDidLoad() {
    super.viewDidLoad()

    backButton = UIButton()
    view.addSubview(lottieAnimation)
    view.addSubview(backButton)
    
    view.backgroundColor = .white

    setupButton()
    setupLottieAnimation()
  }

  func setupButton() {
    backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    backButton.setTitle("Back", for: .normal)

    backButton.titleLabel?.textColor = .black
    backButton.backgroundColor = .gray

    backButton.layer.cornerRadius = CGFloat(buttonSize / 2)
    backButton.snp.makeConstraints { make in
      make.left.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      make.size.equalTo(buttonSize)
    }
  }

  func setupLottieAnimation() {
    let tapped = UITapGestureRecognizer(target: self, action: #selector(lottieTap))
    lottieAnimation.addGestureRecognizer(tapped)
    lottieAnimation.snp.makeConstraints { make in
      make.center.equalTo(view)
    }
  }
  
  @objc func back() {
    navigationController?.popViewController(animated: true)
  }

  @objc func lottieTap() {
    if self.lottieAnimation.animationProgress == 1 {
      self.lottieAnimation.play(fromProgress: 1, toProgress: 0, withCompletion: nil)
    } else {
      self.lottieAnimation.play()
    }
  }
}
