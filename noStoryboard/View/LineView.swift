import UIKit

class LineView: UIView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    self.snp.makeConstraints { make in
      make.height.equalTo(1)
    }
    
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}
