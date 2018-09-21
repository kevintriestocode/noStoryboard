import UIKit
import CoreGraphics
import SnapKit

// Subclassing
class MorePracticeViewController: CoreTextViewController {
  var morePracticeView: MorePracticeView!
  
  override func viewDidLoad() {
    morePracticeView = MorePracticeView()
    print("MorePracticeViewController did load")
    
    view.addSubview(morePracticeView)
    
    morePracticeView.backgroundColor = UIColor.white
    morePracticeView.snp.makeConstraints { make in
      make.edges.equalTo(view)
      make.center.equalTo(view)
    }
  }
}
