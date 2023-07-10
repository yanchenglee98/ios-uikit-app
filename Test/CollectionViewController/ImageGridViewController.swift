import UIKit

class ImageGridViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    var dataSource: ImageDataSource!
    
    // initialise array of images
    let images: [UIImage] = [UIImage(named: "image1")!, UIImage(named: "image2")!, UIImage(named: "bigo3")!, UIImage(named: "bigo4")!, UIImage(named: "image3")!, UIImage(named: "image4")!, UIImage(named: "image5")!, UIImage(named: "image6")!, UIImage(named: "image7")!, UIImage(named: "image8")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initailise data source
        dataSource = ImageDataSource(images: images)
        
        // create a collection view layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        // create the collection view with the layout
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        // register the custom cell class for reuse
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: dataSource.reuseIdentifier)
        
        // add the collection view to the view hierarchy
        view.addSubview(collectionView)
        
        // setup collection view constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    // UICollectionViewDelegateFlowLayout method to set the size of each item dynamically
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = images[indexPath.item]
        let screenWidth = collectionView.bounds.width
        
        let maximumItemWidth = screenWidth - 30 // Adjust spacing as needed
        let aspectRatio = image.size.width / image.size.height
        let itemWidth = maximumItemWidth / 2
        let itemHeight = itemWidth / aspectRatio
        print("\(image.size.width), \(image.size.height), \(maximumItemWidth)")
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        showImage(image: image)
    }
    
    private func showImage(image: UIImage) {
        let imageVC = ImageDetailViewController()
        imageVC.image = image
        navigationController?.pushViewController(imageVC, animated: true)
    }
}
