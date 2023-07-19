import UIKit

class CurrencyConversionViewController: UIViewController {
    private let logo = UIImageView()
    private let yuanLabel = UILabel()
    private let yuanTextField = UITextField()
    private let sgdLabel = UILabel()
    private let sgdTextField = UITextField()
    private let submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupButtonAction()
    }
    
    private func setupUI() {
        view.addSubview(logo)
        logo.image = UIImage(named: "currencylayer")
        logo.contentMode = .scaleAspectFit
        logo.frame = view.bounds
        
        yuanTextField.borderStyle = .roundedRect
        yuanTextField.placeholder = "Enter Chinese Yuan"
        view.addSubview(yuanTextField)
        
        sgdTextField.borderStyle = .roundedRect
        sgdTextField.placeholder = "Enter SGD"
        view.addSubview(sgdTextField)
        
        yuanLabel.text = "Chinese Yuan"
        view.addSubview(yuanLabel)
        
        sgdLabel.text = "Singapore Dollars"
        view.addSubview(sgdLabel)
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.backgroundColor = .systemBlue
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.layer.cornerRadius = 8
        submitButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        view.addSubview(submitButton)
    }
    
    private func setupConstraints() {
        logo.translatesAutoresizingMaskIntoConstraints = false
        yuanTextField.translatesAutoresizingMaskIntoConstraints = false
        sgdTextField.translatesAutoresizingMaskIntoConstraints = false
        yuanLabel.translatesAutoresizingMaskIntoConstraints = false
        sgdLabel.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            logo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            logo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            yuanLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            yuanLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            yuanLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            yuanTextField.topAnchor.constraint(equalTo: yuanLabel.bottomAnchor, constant: 20),
            yuanTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            yuanTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            sgdLabel.topAnchor.constraint(equalTo: yuanTextField.bottomAnchor, constant: 20),
            sgdLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            sgdLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            sgdTextField.topAnchor.constraint(equalTo: sgdLabel.bottomAnchor, constant: 20),
            sgdTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            sgdTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            submitButton.topAnchor.constraint(equalTo: sgdTextField.bottomAnchor, constant: 40),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupButtonAction() {
        submitButton.addTarget(self, action: #selector(submitbuttonTapped), for: .touchUpInside)
    }
    
    @objc private func submitbuttonTapped() {
        APIService.shared.getConversionRate { [weak self] conversionRate in
            // UITextField.text must be used from main thread only
            DispatchQueue.main.async {
                self?.convertCurrency(with: conversionRate)
            }
        }
    }
    
    private func convertCurrency(with conversionRate: Double) {
        print(conversionRate)
        guard let yuanString = yuanTextField.text,
              let yuanAmount = Double(yuanString),
              let sgdString = sgdTextField.text,
              let sgdAmount = Double(sgdString) else {
            // handle invalid input
            print("invalid input")
            showInvalidInputAlert()
            return
        }
        
        let convertedSGD = yuanAmount * conversionRate
        let convertedYuan = sgdAmount / conversionRate
        
        sgdTextField.text = String(format: "%.2f", convertedSGD)
        yuanTextField.text = String(format: "%.2f", convertedYuan)
    }
    
    private func showInvalidInputAlert() {
        let alert = UIAlertController(title: "Invalid Input", message: "Please enter valid numeric values", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
