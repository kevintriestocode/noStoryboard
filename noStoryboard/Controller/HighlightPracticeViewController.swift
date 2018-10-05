import UIKit

class HighlightPractiveViewController: UIViewController {
  
  override func viewDidLoad() {
    print("HighlightPractiveViewController did load")
    
    // Instantiating
    let highlightPracticeView = HighlightPracticeView()
    view.addSubview(highlightPracticeView)
    
    highlightPracticeView.backgroundColor = UIColor.white
    highlightPracticeView.snp.makeConstraints { make in
      make.edges.equalTo(view)
      make.center.equalTo(view)
    }
    
  }
}
