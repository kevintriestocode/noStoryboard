import Foundation
import UIKit

public struct Configuration {
  public static var dataSource = [ "One", "Two", "Three", "Four", "Five" ]
  
  // Adobe Color CC
  public struct Color {
    public static var backgroundColor = UIColor(red: 54/255, green: 117/255, blue: 219/255, alpha: 1)
    public static var backgroundColorDark = UIColor(red: 48/255, green: 71/255, blue: 242/255, alpha: 1)
    public static var backgroundColorDarker = UIColor(red: 73/255, green: 46/255, blue: 232/255, alpha: 1)
    public static var backgroundColorLight = UIColor(red: 48/255, green: 173/255, blue: 242/255, alpha: 1)
    public static var backgroundColorLighter = UIColor(red: 46/255, green: 215/255, blue: 232/255, alpha: 1)
  }
  
  public struct Label {
    public static var cornerRadius = CGFloat(9)
  }
}
