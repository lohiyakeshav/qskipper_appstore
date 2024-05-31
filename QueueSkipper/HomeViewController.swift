//
//  HomeViewController.swift
//  QueueSkipper
//
//  Created by ayush yadav on 24/05/24.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    
    @IBOutlet var searchBar: UISearchBar!
    
    var filteredRestaurants: [Restaurant] = []
    var isSearching: Bool = false
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return RestaurantController.shared.featuredItem.count
        case 1:
            return isSearching ? filteredRestaurants.count:RestaurantController.shared.restaurant.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBanner", for: indexPath) as! HomeBannerCollectionViewCell
            cell.imageView.image = UIImage(named: RestaurantController.shared.featuredItem[indexPath.row].image)
            cell.dishName.text = RestaurantController.shared.featuredItem[indexPath.row].name
            cell.restaurantName.text = RestaurantController.shared.featuredItem[indexPath.row].restaurant
            //cell.isUserInteractionEnabled = true
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantList", for: indexPath) as! RestaurantListCollectionViewCell
            let rest = isSearching ? filteredRestaurants[indexPath.row] : RestaurantController.shared.restaurant[indexPath.row]
                       // cell.imageView.image = UIImage(named: rest.restImage)
                        cell.name.text = rest.restName
                        cell.waitingTime.text = "\(rest.restWaitingTime) Mins"
                        cell.cuisine.text = rest.cuisine
                        return cell
        default:
            return UICollectionViewCell()
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBanner", for: indexPath)
//            return cell
        }
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
        } else {
            isSearching = true
            filteredRestaurants = RestaurantController.shared.restaurant.filter { $0.restName.lowercased().contains(searchText.lowercased()) }
        }
        collectionView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        searchBar.resignFirstResponder()
        collectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        let featuredNib = UINib(nibName: "HomeBanner", bundle: nil)
        collectionView.register(featuredNib, forCellWithReuseIdentifier: "HomeBanner")
        let restaurantNib = UINib(nibName: "RestaurantList", bundle: nil)
        collectionView.register(restaurantNib, forCellWithReuseIdentifier: "RestaurantList")

        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        filteredRestaurants = RestaurantController.shared.restaurant
        
       
    }
   
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
            
            headerView.headerLabel.text = RestaurantController.shared.homeHeaders[indexPath.section]
            headerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 17)
            //headerView.button.tag = indexPath.section
            //headerView.button.setTitle("See All", for: .normal)
            //headerView.button.addTarget(self, action: #selector(headerButtonTapped(_:)), for: .touchUpInside)
            
            return headerView
        }
        fatalError("Unexpected element kind")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex, env) -> NSCollectionLayoutSection? in let section: NSCollectionLayoutSection
            
            switch sectionIndex {
            case 0:
                section = self.generateSection0()
            case 1:
                section = self.generateSection1()
            default:
                section = self.generateSection0()
            }
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [header]
            return section
        }
        return layout
    }
    
    func generateSection0() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    func generateSection1() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(280))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
        let storyboard = UIStoryboard(name: "Restaurants", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
//        viewController.restaurantSelected = Restaurant()
        switch indexPath.section {
        case 0:
            for rest in RestaurantController.shared.restaurant {
                if rest.restName == RestaurantController.shared.featuredItem[indexPath.row].restaurant {
                    print(rest)
                    viewController.restaurantSelected = rest
                    
                }
            }
            
        default:
            viewController.restaurantSelected = isSearching ? filteredRestaurants[indexPath.row] : RestaurantController.shared.restaurant[indexPath.row]
        
        }
        let navVC = self.navigationController
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
        navVC?.pushViewController(viewController, animated: true)
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
