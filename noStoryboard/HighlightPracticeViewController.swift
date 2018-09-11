import Foundation
import UIKit
import CoreGraphics

public class HighlightPractiveViewController: UIViewController {
  var textLabel: UILabel!
  
  override public func viewDidLoad() {
    let labelText = NSAttributedString(string: "Highlight me.")
    
    textLabel = UILabel()
    textLabel.attributedText = labelText
    
    view.addSubview(textLabel)
    view.backgroundColor = .white
    
    textLabel.snp.makeConstraints { make in
      make.top.left.right.bottom.equalTo(view).inset(30)
    }
    
    // Here's where it gets dirty.
    let size = labelText.size()
    let context = NSStringDrawingContext()
    let rect = labelText.boundingRect(with: size, options: .usesLineFragmentOrigin, context: context)
    
    let range = CFRangeMake(0, labelText.length)
    
    let path = CGPath(rect: rect, transform: nil)
    
    let framesetter = CTFramesetterCreateWithAttributedString(labelText)
    let frame = CTFramesetterCreateFrame(framesetter, range, path, nil)
    let lines = CTFrameGetLines(frame)
    
    var origins = lines
//    let lineOrigins = CTFrameGetLineOrigins(frame, range, origins)
  }
}
