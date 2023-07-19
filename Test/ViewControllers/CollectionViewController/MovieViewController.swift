import UIKit

class MovieViewController: UIViewController {
    private var searchBar: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.placeholder = "Enter the movie name"
        sb.searchBar.searchBarStyle = .minimal
        return sb
    }()
    
    private var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3-10, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.ID)
        return cv
    }()
    
    private var movies = [Title]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Movie Search"
        view.backgroundColor = .systemBackground
        searchBar.searchResultsUpdater = self
        navigationItem.searchController = searchBar
        view.addSubview(movieCollectionView)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        configureUI()
    }
    
    func configureUI() {
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        movieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension MovieViewController: UISearchResultsUpdating {
    // called whenever the text entered in the search bar changes or when search button is tapped
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        APIService.shared.getMovies(for: query.trimmingCharacters(in: .whitespaces)) { titles, error in
            if let titles =  titles {
                self.movies = titles
                DispatchQueue.main.async {
                    self.movieCollectionView.reloadData()
                }
            }
        }
    }
}

extension MovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // determines number of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    // populates the cell with API responses
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.ID, for: indexPath) as? MovieCell {
            cell.updateCell(posterURL: movies[indexPath.row].poster_path)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        showMovieDetails(movie)
    }
    
    private func showMovieDetails(_ movie: Title) {
        print(movie)
        let movieVC = MovieDetailViewController()
        movieVC.movie = movie
        navigationController?.pushViewController(movieVC, animated: true)
    }
}
