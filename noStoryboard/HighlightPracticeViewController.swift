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
    
    // Initialize a graphics context in iOS.
    let context: CGContext = UIGraphicsGetCurrentContext()!
    print(context)
    
    // Flip the context coordinates, in iOS only.
    context.translateBy(x: 0, y: self.bounds.size.height)
    context.scaleBy(x: 1.0, y: -1.0)
    
    // Set the text matrix.
    context.textMatrix = CGAffineTransform.identity
    
    // Create a path which bounds the area where you will be drawing text.
    let path = CGMutablePath()
    
    // Example bounds.
    let bounds = CGRect(x: 10.0, y: 10.0, width: 200.0, height: 200.0)
    path.addRect(bounds)
    
    // Initialize a string.
    let textString = NSString(string: "Hello, World!") // CF & NS are toll-free bridged.
    
    // Create a mutable attributed string with a max length of 0.
    // The max length is a hint as to how much internal storage to reserve.
    // 0 means no hint.
    let attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
    
    // Copy the textString into the newly created attrString
    CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), textString)

    
    // Create a color that will be added as an attribute to the attrString.
    let rgbColorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
    let components: [CGFloat] = [1.0, 0.0, 0.0, 0.8]
    let red: CGColor = CGColor(colorSpace: rgbColorSpace, components: components)!
    
    // Set the color of the first 12 chars to red.
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12), kCTForegroundColorAttributeName, red)
    
    // Create the framesetter with the attributed string.
    let framesetter = CTFramesetterCreateWithAttributedString(attrString!)

    // Create a frame.
    let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
    
    // -- End of Core Text Programming Guide 2-1 --
    
    let lines: CFArray = CTFrameGetLines(frame)
    let numOfLines: CFIndex = CFArrayGetCount(lines)
    var lineOrigins = [CGPoint](repeating: CGPoint.zero, count: numOfLines)
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &lineOrigins)
    
    
    for i in 0..<numOfLines {
      let line: CTLine = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), to: CTLine.self)
      let runs = CTLineGetGlyphRuns(line)
      let numOfRuns: CFIndex = CFArrayGetCount(runs)
      
      for j in 0..<numOfRuns {
        let run: CTRun = unsafeBitCast(CFArrayGetValueAtIndex(runs, j), to: CTRun.self)
        let range = CTRunGetStringRange(run)
        
        var runBounds = CGRect.zero
        var width: CGFloat = 0
        var height: CGFloat = 0
        var ascent: CGFloat = 0
        var descent: CGFloat = 0
        var leading: CGFloat = 0
        
        let offsetX: CGFloat = CTLineGetOffsetForStringIndex(line, numOfRuns, nil)
        
        width = CGFloat(CTRunGetTypographicBounds(run, range, &ascent, &descent, &leading))
        width += leading
        height = ascent + descent
        print(String(format: "Line %ld : Offset Y: %f", i + 1, lineOrigins[i].y))
        runBounds = CGRect(x: lineOrigins[i].x + offsetX, y: lineOrigins[i].y + descent, width: width, height: height)
        
        // UIBezierPath
        let bezierPath = UIBezierPath(roundedRect: runBounds, cornerRadius: 3)
        UIColor(red: 200/255, green: 200/255, blue: 222/255, alpha: 1).setFill()
        bezierPath.fill()
        
      }
    }
    
    // Draw the specified frame in the given context.
    CTFrameDraw(frame, context)
  }
}
