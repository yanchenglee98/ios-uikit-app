import UIKit

class CollectionViewCell: UICollectionViewCell {
    var view = UIView()
    
    func setupCell(view: UIView) {
        self.view = view
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundColor = .blue
    }
}

class CustomCollectionViewController: UICollectionViewController {
    private lazy var firstView = FirstView()
    private lazy var secondView = SecondView()
    private lazy var thirdCell = ThirdView()
    
    private lazy var cells: [(view: UIView, id: String)] = [
        (firstView, FirstView.id),
        (secondView, SecondView.id),
        (thirdCell, ThirdView.id)
    ]
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        super.init(collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
    
    private func setupCollectionView() {
        // register the different views with different reuse identifier
        cells.forEach { collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: $0.id) }
        collectionView.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCell.id)
    }
}

extension CustomCollectionViewController {
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cells[indexPath.row].id, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.setupCell(view: cells[indexPath.row].view)
        return cell
    }
}

extension CustomCollectionViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterCell.id, for: indexPath)
            return footerView
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 120)
    }
}
