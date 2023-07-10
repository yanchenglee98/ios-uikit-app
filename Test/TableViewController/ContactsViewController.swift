//
//  ContactsViewController.swift
//  Test
//
//  Created by Lee Yan Cheng on 22/6/23.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate, ContactTableViewCellDelegate {
    let contactsTableView = UITableView()
    private let contacts = APIService.shared.getContacts() // model
    var searchBar: UISearchBar!
    var filteredContacts: [Contact] =  APIService.shared.getContacts()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        searchBar.delegate = self
        searchBar.placeholder = "Search contacts"
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        // Do any additional setup after loading the view.
        view.addSubview(contactsTableView) // add to subview before anchoring it
        
        contactsTableView.translatesAutoresizingMaskIntoConstraints = false // enable auto layout

        // let table view know where its data source protocol methods are
        contactsTableView.dataSource = self
        contactsTableView.delegate = self
        //resgister the cell identifier
        contactsTableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "contactCell")
        
        let constraints = [
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
             
            contactsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            contactsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contactsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contactsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
         ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        cell.contact = filteredContacts[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = filteredContacts[indexPath.row]
        showContactDetail(contact: contact)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    private func showContactDetail(contact: Contact) {
        let contactDetailVC = ContactDetailViewController()
        contactDetailVC.contact = contact
        navigationController?.pushViewController(contactDetailVC, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredContacts = searchText.isEmpty ? contacts : contacts.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        contactsTableView.reloadData()
    }
    
    func imageTapped(image: UIImage) {
        let imageVC = ImageDetailViewController()
        imageVC.image = image
        navigationController?.pushViewController(imageVC, animated: true)
//        present(imageVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
