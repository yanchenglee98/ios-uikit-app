import UIKit
 
class SampleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    private var data = [String]()
    var isPaginationOn = false
    var tableView: UITableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        makeRequest(isPagination: false, completion: {[weak self] response in
            switch response{
            case .success(let data):
                self?.data.append(contentsOf: data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure:
                break
                
            }
        })
    }
    func makeRequest(isPagination: Bool, completion: @escaping (Result<[String], Error>) -> Void){
        if isPagination{
            isPaginationOn = true
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + (isPagination ? 2 : 3), execute: {
            let data = ["Hello","You", "are","Welcome", "To", "Mobikul", "Hello","You", "are","Welcome", "To", "Mobikul","Hello","You", "are","Welcome", "To", "Mobikul","Hello","You", "are","Welcome", "To", "Mobikul",
                        "Mobikul","Hello","You", "are","Welcome", "To", "Mobikul"]
            let nextData = ["Enjoy", "The", "Pagination", "Blog",
                            "Enjoy", "The", "Pagination", "Blog",
                            "Enjoy", "The", "Pagination", "Blog"]
            completion(.success(isPagination ? nextData : data))
            if isPagination{
                self.isPaginationOn = false
            }
        })
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        if pos > tableView.contentSize.height-50 - scrollView.frame.size.height{
            guard !isPaginationOn else{
                return
            }
            self.makeRequest(isPagination:  true){
                [weak self]response in
                switch response{
                case .success(let data):
                    self?.data.append(contentsOf: data)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    break
                }
            }
            
        }
    }
    
}
 
extension SampleViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)as! TableViewCell
        cell.label.text = self.data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

class TableViewCell: UITableViewCell {
    let label: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
}
