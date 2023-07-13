//
//  TabBar.swift
//  Test
//
//  Created by Lee Yan Cheng on 20/6/23.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupViewControllers()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // provide tab bar with coressponding ViewController, icon image and title
    func setupViewControllers() {
        viewControllers = [
            createNavController(for: ImageGridViewController(), title: NSLocalizedString("Photos", comment: ""), image: UIImage(systemName: "photo")!),
            createNavController(for: CustomCollectionViewController(), title: NSLocalizedString("Wallpapers", comment: ""), image: UIImage(systemName: "photo.stack")!),
            createNavController(for: ContactsViewController(), title: NSLocalizedString("Contacts", comment: ""), image: UIImage(systemName: "person")!),
            createNavController(for: MovieViewController(), title: NSLocalizedString("Movies", comment: ""), image: UIImage(systemName: "play.tv")!),
            createNavController(for: CurrencyConversionViewController(), title: NSLocalizedString("Currency", comment: ""), image: UIImage(systemName: "dollarsign.arrow.circlepath")!)
        ]
    }
    
    // generate the navigationController for tab bar with title, icon and icon title
    // Tab bar items are configured through their corresponding view controller
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        rootViewController.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        return navController
    }

}
