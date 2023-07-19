import UIKit
import SnapKit

public class FooterCell: UICollectionReusableView {
    static let id = "FooterCell"
    
    private lazy var writeMeLabel: UILabel = {
        let label = UILabel()
        label.text = "Write me"
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var tgButton: UIButton = {
        let but = UIButton()
        but.setImage(UIImage.Icons.tg_icon, for: .normal)
        but.addTarget(self, action: #selector(openTelegram), for: .touchUpInside)
        return but
    }()
    
    private lazy var inButton: UIButton = {
        let but = UIButton()
        but.setImage(UIImage.Icons.in_icon, for: .normal)
        but.addTarget(self, action: #selector(openLinkedin), for: .touchUpInside)
        return but
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(tgButton)
        stackView.addArrangedSubview(inButton)
        stackView.spacing = 24
        return stackView
    }()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    private func setupView() {
        [writeMeLabel, buttonsStackView].forEach(addSubview(_:))
        setupConstraints()
    }
    
    private func setupConstraints() {
        writeMeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(writeMeLabel.snp_bottomMargin).offset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.iconSize)
            make.bottom.equalToSuperview().inset(5).priority(.low)
        }
        
        tgButton.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.iconSize)
        }
        
        inButton.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.iconSize)
        }
    }
    
    @objc private func openTelegram() {
        if let url = URL(string: "https://t.me/Belo4kaS") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func openLinkedin() {
        if let url = URL(string: "https://www.linkedin.com/mwlite/in/anastasiia-gerasimova-888bb41b6") {
            UIApplication.shared.open(url)
        }
    }
}
