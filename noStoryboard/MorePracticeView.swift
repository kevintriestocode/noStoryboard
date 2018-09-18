// Listing 2-2  Typesetting a simple text label

import UIKit
import CoreGraphics
import CoreText

// Subclassing
class MorePracticeView: UIView {
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    // Initialize the string, font, and context
    let string: NSString = NSString() // toll-free bridged with CFString. Don't know how to initialize a CFString...
    var font: CTFont = CTFontCreateWithName(string, 12, nil)
    var context: CGContext = UIGraphicsGetCurrentContext()!
    
    var keys[] = { kCTFontAttributeName }
  }
}
