import UIKit

class ImageDataSource: NSObject, UICollectionViewDataSource {
    let reuseIdentifier = "ImageCell"
    let images: [UIImage] // array of images
    
    init(images: [UIImage]) {
        self.images = images
    }
    
    // determine no. of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
        let image = images[indexPath.item]
        cell.imageView.image = image
        return cell
    }
}
