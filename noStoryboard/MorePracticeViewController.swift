import UIKit
import CoreGraphics
import SnapKit

// Subclassing
class MorePracticeViewController: CoreTextViewController {
  var morePracticeView: MorePracticeView!
  
  override func viewDidLoad() {
    print("MorePracticeViewController did load")
    
    morePracticeView = MorePracticeView()
    view.addSubview(morePracticeView)
    
    morePracticeView.snp.makeConstraints { make in
      make.edges.equalTo(view)
      make.center.equalTo(view)
    }
  
  }
  
  

}
