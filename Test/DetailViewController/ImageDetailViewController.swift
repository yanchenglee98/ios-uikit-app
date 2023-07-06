import UIKit

class ImageDetailViewController: UIViewController {
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        
        // use these to constraint images instead of autolayout
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16.0
        imageView.layer.masksToBounds = true
    }
}
