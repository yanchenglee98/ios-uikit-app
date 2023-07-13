import UIKit
import SnapKit

final class FirstView: UIView {
    static let id = "FirstCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .Photos.mountain
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .purple
        addSubview(imageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        snp.makeConstraints { make in
            make.width.equalTo(Constants.width)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
