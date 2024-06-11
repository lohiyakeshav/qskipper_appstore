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
            //GET call to the server to fetch TopPicks
            Task.init {
                if let url = URL(string: "https://queueskipperbackend.onrender.com/get_product_photo/\(RestaurantController.shared.featuredItem[indexPath.row].dishId)") {
                                if let image = try? await NetworkUtils.shared.fetchImage(from: url) {
                                    
                                    
                                    cell.imageView.image = image
                                } else {
                                    print("Failed to load image for restaurant: ")
                                }
                            } else {
                                print("Invalid URL for restaurant: ")
                            }
                        }
            
            cell.dishName.text = RestaurantController.shared.featuredItem[indexPath.row].name
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantList", for: indexPath) as? RestaurantListCollectionViewCell else {
                            fatalError("Could not dequeue cell with identifier: RestaurantList")
                        }
                        let restaurant = isSearching ? filteredRestaurants[indexPath.row] : RestaurantController.shared.restaurant[indexPath.row]
                        
                        cell.name.text = restaurant.restName
                        cell.waitingTime.text = "\(restaurant.restWaitingTime) Mins"
                        cell.cuisine.text = restaurant.cuisine
            //GET call to the server to fetch Restaurant Images
            Task.init {
                            if let url = URL(string: "https://queueskipperbackend.onrender.com/get_restaurant_photo/\(restaurant.restId)") {
                                if let image = try? await NetworkUtils.shared.fetchImage(from: url) {
                                    
                                    RestaurantController.shared.setRestaurantImage(image: image, index: indexPath.row)
                                    
                                    cell.imageView.image = image
                                } else {
                                    print("Failed to load image for restaurant: \(restaurant.restName)")
                                }
                            } else {
                                print("Invalid URL for restaurant: \(restaurant.restName)")
                            }
                        }
           
            return cell
        default:
            return UICollectionViewCell()
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
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.isNavigationBarHidden = false
        self.hidesBottomBarWhenPushed = false
        searchBar.delegate = self
        
        //GET call to the server to fetch Restaurants
        Task.init {
            do {
                print("Called for menu")
                let list = try await NetworkUtils.shared.fetchRestaurants()
                print("Called for dusra menu")
                RestaurantController.shared.setRestaurant(restaurant: list)
                print(RestaurantController.shared.restaurant)
                let topPicks = try await NetworkUtils.shared.fetchTopPicks()
                RestaurantController.shared.setFeaturedItem(dish: topPicks)
                await MainActor.run {
                    self.collectionView.reloadData()
                }
            } catch {
                print("error")
            }
        }
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
            
            headerView.headerLabel.text = RestaurantController.shared.homeHeaders[indexPath.section]
            
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 40)
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

        switch indexPath.section {
        case 0:
            for rest in RestaurantController.shared.restaurant {
                if rest.restId == RestaurantController.shared.featuredItem[indexPath.row].restaurant {
                    print(rest)
                    viewController.restaurantSelected = rest
                    
                }
            }
            
        default:
            viewController.restaurantSelected = isSearching ? filteredRestaurants[indexPath.row] : RestaurantController.shared.restaurant[indexPath.row]
        
        }
        RestaurantController.shared.removeFeaturedMenu()
        RestaurantController.shared.removeDish()
        show(viewController, sender: self)
    }
    
}
