// Listing 2-1  Typesetting a simple paragraph

import UIKit
import CoreGraphics

// Subclassing
class HighlightPracticeView: UIView {
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    // Initialize a graphics context in iOS.
    let context: CGContext = UIGraphicsGetCurrentContext()!
    
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
    let components: [CGFloat] = [33/255, 204/255, 118/255, 1]
    let aColor: CGColor = CGColor(colorSpace: rgbColorSpace, components: components)!
    
    // Set the color of the first 12 chars to red.
    CFAttributedStringSetAttribute(attrString, CFRangeMake(12, 1), kCTForegroundColorAttributeName, aColor)
    
    // Create the framesetter with the attributed string.
    let framesetter = CTFramesetterCreateWithAttributedString(attrString!)
    
    // Create a frame: CTFrame
    let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
    
    // -- End of Core Text Programming Guide 2-1 --
    
    // TODO: Study:
    // TODO:   |
    // TODO:   |
    // TODO:   V
    
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
        
        //        print(width, height, ascent, descent, leading)
        
        width = CGFloat(CTRunGetTypographicBounds(run, range, &ascent, &descent, &leading))
        width += leading
        height = ascent + descent
        
        let offsetX: CGFloat = CTLineGetOffsetForStringIndex(line, numOfRuns, nil)
        runBounds = CGRect(x: lineOrigins[i].x + offsetX, y: lineOrigins[i].y + descent, width: width, height: height)
        
        // UIBezierPath
        let bezierPath = UIBezierPath(roundedRect: runBounds, cornerRadius: 0)
        UIColor(red: 255/255, green: 243/255, blue: 204/255, alpha: 1).setFill()
        bezierPath.fill()
        
      }
    }
    
    // Draw the specified frame in the given context.
    CTFrameDraw(frame, context)
  }
}
