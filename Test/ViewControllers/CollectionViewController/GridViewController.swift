import UIKit

class GridViewController: UIViewController {
    var gridCollectionView:UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        gridCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        gridCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "GridCell")
        gridCollectionView?.backgroundColor = UIColor.systemBackground
        
        gridCollectionView?.dataSource = self
        gridCollectionView?.delegate = self
        
        view.addSubview(gridCollectionView ?? UICollectionView())
        
        self.view = view
    }
}

extension GridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25 // no of cells to display
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath)
        gridCell.backgroundColor = UIColor.blue
        return gridCell
    }
}

extension GridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
    }
}
