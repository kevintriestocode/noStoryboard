import UIKit
import CoreGraphics
import SnapKit

public class HighlightPractiveViewController: UIViewController {
  
  override public func viewDidLoad() {
    let highlightPracticeView = HighlightPracticeView()
    view.addSubview(highlightPracticeView)
    
    highlightPracticeView.snp.makeConstraints { make in
      make.edges.equalTo(view)
      make.center.equalTo(view)
    }
    highlightPracticeView.backgroundColor = UIColor.white
  }
}

class HighlightPracticeView: UIView {
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    let context: CGContext = UIGraphicsGetCurrentContext()!
    print(context)
    context.translateBy(x: 0, y: self.bounds.size.height)
    context.scaleBy(x: 1.0, y: -1.0)
    context.textMatrix = CGAffineTransform.identity
    
    let path = CGMutablePath()
    
    let bounds = CGRect(x: 10.0, y: 10.0, width: 200.0, height: 200.0)
    path.addRect(bounds)
    
    let textString = NSString(string: "Hello, World!") // CF & NS are toll-free bridged.
    
    let attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
    
    CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), textString)
    
    let rgbColorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
    let components: [CGFloat] = [1.0, 0.0, 0.0, 0.8]
    let red: CGColor = CGColor(colorSpace: rgbColorSpace, components: components)!
    
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12), kCTForegroundColorAttributeName, red)
    
    let framesetter = CTFramesetterCreateWithAttributedString(attrString!)
    let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
    
    
    
    // CFArray
    let lines = CTFrameGetLines(frame)
    let numOfLines = CFArrayGetCount(lines)
    var lineOrigins = [CGPoint](repeating: CGPoint.zero, count: numOfLines)
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &lineOrigins)
    
    // SWIFTIFY
    for i in 0..<numOfLines {
      var line = CFArrayGetValueAtIndex(lines, i)
      var runs = CTLineGetGlyphRuns(line as! CTLine)
      var numOfRuns: size_t = CFArrayGetCount(runs)
      
      for j in 0..<numOfRuns {
        var run = CFArrayGetValueAtIndex(runs, j)
        
        var strFrame = CGRect.zero
        var width: CGFloat = 0
        var height: CGFloat = 0
        var leading: CGFloat = 0
        var ascent: CGFloat = 0
        var descent: CGFloat = 0
        var strRange: CFRange = CTRunGetStringRange(run as! CTRun)
        var offsetX: CGFloat = CTLineGetOffsetForStringIndex(line as! CTLine, strRange.location, nil)
        
        width = CGFloat(CTRunGetTypographicBounds(run as! CTRun, CFRangeMake(0, 0), &ascent, &descent, &leading))
        width += leading
        height = ascent + descent
        print(String(format: "Line %ld : Offset Y: %f", i + 1, lineOrigins[i].y))
        strFrame = CGRect(x: lineOrigins[i].x + offsetX, y: lineOrigins[i].y - descent, width: width, height: height)
        strFrame = strFrame.integral
        var attr = CTRunGetAttributes(run as! CTRun)
        
      }
    }
    CTFrameDraw(frame, context)
  }
}
