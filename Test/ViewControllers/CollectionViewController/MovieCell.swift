import Foundation
import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    static let ID = "MovieCell"
    private var moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        moviePosterImageView.layer.cornerRadius = 8.0
        moviePosterImageView.layer.masksToBounds = true // need to masks to bounds to get corner radius
        addSubview(moviePosterImageView)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init code has not been implemented")
    }
}

extension MovieCell {
    func configureUI() {
        moviePosterImageView.translatesAutoresizingMaskIntoConstraints = false
        moviePosterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        moviePosterImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        moviePosterImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        moviePosterImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func updateCell(posterURL: String?) {
        if let posterURL = posterURL {
            guard let completeURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterURL)") else { return }
            self.moviePosterImageView.sd_setImage(with: completeURL)
        }
    }
}
