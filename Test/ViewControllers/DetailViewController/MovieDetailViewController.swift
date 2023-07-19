import UIKit

class MovieDetailViewController: UIViewController {
    let moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8.0
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    var movie:Title? {
        didSet {
            guard let movie = movie else {return}
            nameLabel.text = movie.original_title
            if let posterURL = movie.poster_path {
                guard let completeURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterURL)") else { return }
                self.moviePosterImageView.sd_setImage(with: completeURL)
            }
            overviewLabel.text = movie.overview
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(moviePosterImageView)
        moviePosterImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        moviePosterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        moviePosterImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        moviePosterImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        view.addSubview(overviewLabel)
        overviewLabel.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: 10).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
}
