import UIKit
import SnapKit

final class ThirdView: UICollectionView {
    static let id = "ThirdCell"

    private let photos: [UIImage?] = [.Photos.sea,
                                      .Photos.bridge,
                                      .Photos.dandelion,
                                      .Photos.killer_whale,
                                      .Photos.polar,
                                      .Photos.winter,
                                      .Photos.river,
                                      .Photos.forest_river]

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 3
        super.init(frame: .zero, collectionViewLayout: layout)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        showsHorizontalScrollIndicator = false
        register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.id)
        dataSource = self
        delegate = self
    }
}

extension ThirdView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.id, for: indexPath) as? PhotosCell else {
            return UICollectionViewCell()
        }
        cell.addImage(image: photos[indexPath.row])
        return cell
    }
}

extension ThirdView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.photosCellWidth, height: Constants.photosCellHeight)
    }
}

final class PhotosCell: UICollectionViewCell {
    static let id = "PhotosCell"

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addImage(image: UIImage?) {
        guard let image = image else { return }
        imageView.image = image
    }

    private func setupView() {
        addSubview(imageView)
        setupConstraints()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
