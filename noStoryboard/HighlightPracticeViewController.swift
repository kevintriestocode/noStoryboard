import Foundation
import UIKit
import UIKit.UIGraphicsRenderer
import CoreGraphics
import SnapKit

public class HighlightPractiveViewController: UIViewController {
  var textLabel: UILabel!
  var labelText: NSAttributedString!
  var renderer: UIGraphicsRenderer!

  override public func viewDidLoad() {
    labelText = NSAttributedString(string: "Highlight me.")
    
    renderer = UIGraphicsRenderer(bounds: view.frame)
    
    textLabel = UILabel()
    textLabel.attributedText = labelText
    textLabel.textAlignment = .center
    
    view.addSubview(textLabel)
    view.backgroundColor = .white
    
    textLabel.snp.makeConstraints { make in
      make.top.left.right.bottom.equalTo(view).inset(30)
      make.center.equalTo(view.snp.center)
    }

    drawRect()

    // Here's where it gets dirty.
//    let size = labelText.size()
//    let context = NSStringDrawingContext()
//    let rect = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, context: context)
//
//
//
//    let path = CGPath(rect: rect, transform: nil)
//
//    let framesetter = CTFramesetterCreateWithAttributedString(labelText)
//    let frame = CTFramesetterCreateFrame(framesetter, range, path, nil)
//    let lines = CTFrameGetLines(frame)
//
//    var origins = lines
////    let lineOrigins = CTFrameGetLineOrigins(frame, range, origins)
  }
  
  func drawRect() {
    
    let size = labelText.size()
    let rect = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
    print(rect)
    
    
    
    let currentColor = UIColor(red: 200/255, green: 180/255, blue: 160/255, alpha: 1)
    
    let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 10)
    print(bezierPath)
    
    
    

  }
}
