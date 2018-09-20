import UIKit
import CoreGraphics
import SnapKit

// Subclassing
class MorePracticeViewController: CoreTextViewController {
  var morePracticeView: MorePracticeView!
  
  override func viewDidLoad() {
    print("MorePracticeViewController did load")
    
    morePracticeView = MorePracticeView()
    morePracticeView.backgroundColor = UIColor.white
    view.addSubview(morePracticeView)
    
    morePracticeView.snp.makeConstraints { make in
      make.edges.equalTo(view)
      make.center.equalTo(view)
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    print("MorePracticeViewController will disappear")
  }
  
  

}
