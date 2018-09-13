import UIKit
import CoreGraphics

public class HighlightPractiveViewController: UIViewController {
  
  override public func viewDidLoad() {
    drawRect()
  }
  
  func drawRect() {
    // Initialize a graphics context
    let context: CGContext = UIGraphicsGetCurrentContext()!
    
    // Flip teh context coordinates, in iOS only.
    context.translateBy(x: 0, y: view.bounds.size.height)
    context.scaleBy(x: 1.0, y: -1.0)
    
    // Set the text matrix.
    /// Don't know Swift equivalent of @objc CGContextSetTextMatrix ...
    context.textMatrix = CGAffineTransform.identity
    
    // Create a path which bounds the area where you will be drawing text.
    let path = CGMutablePath()
    
    // In this simple example, initialize a rectangular path.
    /// CGRect bounds = CGRectMake(10.0, 10.0, 200.0, 200.0);
    /// CGPathAddRect(path, NULL, bounds );
    let bounds = CGRect(x: 10.0, y: 10.0, width: 200.0, height: 200.0)
    path.addRect(bounds)
    
    // Initialize a string.
    // CFStringRef textString = CFSTR("Hello, World! I know nothing in the world that has as much power as a word. Sometimes I write one, and I look at it, until it begins to shine.");
    let textString = NSString(string: "Hello, World!") // CF & NS are toll-free bridged.

    // Create a mutable attributed string with a max length of 0.
    /// The max length is a hint as to how much internal storage to reserve.
    /// 0 means no hint.
    let attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0)
    
    // Copy the textString into the newly created attrString
    /// CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0), textString);
    CFAttributedStringReplaceString(attrString, CFRangeMake(0, 0), textString)
    
    // Create a color that will be added as an attribute to the attrString.
    /// CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    /// CGFloat components[] = { 1.0, 0.0, 0.0, 0.8 };
    /// CGColorRef red = CGColorCreate(rgbColorSpace, components);
    /// CGColorSpaceRelease(rgbColorSpace);
    let rgbColorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
    let components: [CGFloat] = [1.0, 0.0, 0.0, 0.8]
    let red: CGColor = CGColor(colorSpace: rgbColorSpace, components: components)!
    
    // Set the color of the first 12 chars to red.
    /// CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12), kCTForegroundColorAttributeName, red);
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, 12), kCTForegroundColorAttributeName, red)
    
    // Create the framesetter with the attributed string.
    /// CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    /// CFRelease(attrString); -- in swift: --> 'CFRelease' is unavailable: Core Foundation objects are automatically memory managed
    let framesetter = CTFramesetterCreateWithAttributedString(attrString!)
  
    // Create a frame.
    /// CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
    
    // Draw the specified frame in the given context.
    /// CTFrameDraw(frame, context);
    
    CTFrameDraw(frame, context)
    
    // Release the objects we used.
    /// CFRelease(frame);
    /// CFRelease(path);
    /// CFRelease(framesetter);

    
  }
}
