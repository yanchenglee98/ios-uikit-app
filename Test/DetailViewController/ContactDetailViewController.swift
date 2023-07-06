import UIKit

class ContactDetailViewController: UIViewController {
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill //image will never be stretched vertically or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false //enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    let jobTitleDetailedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let countryImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 13
        img.clipsToBounds = true
        return img
    }()
    
    var contact:Contact? {
        didSet {
            guard let contactItem = contact else {return}
            profileImageView.image = UIImage(named: contactItem.name)
            nameLabel.text = contactItem.name
            jobTitleDetailedLabel.text = contactItem.jobTitle
            countryImageView.image = UIImage(named: contactItem.country)
            navigationController?.navigationItem.title = contactItem.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(jobTitleDetailedLabel)
        view.addSubview(countryImageView)
        
        
//        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        profileImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:350).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:350).isActive = true
        
        jobTitleDetailedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        jobTitleDetailedLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10).isActive = true
        
        countryImageView.topAnchor.constraint(equalTo: jobTitleDetailedLabel.bottomAnchor, constant: 10).isActive = true
        countryImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
