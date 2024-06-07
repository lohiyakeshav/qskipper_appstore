//
//  MenuViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 17/05/24.
//

import UIKit


class MenuViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    

    var restaurantSelected = Restaurant()
    
   
    @IBOutlet var collectionView: UICollectionView!
    
    
//    init?(coder: NSCoder, restaurantSelected: Restaurant) {
//        self.restaurantSelected = restaurantSelected
//        super.init(coder: coder)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            //return Menu.featuredItems.count
            return RestaurantController.shared.featuredMenu.count
        case 2:
            //return Menu.dish.count
            return RestaurantController.shared.dish.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantDetails", for: indexPath) as! RestaurantDetailsCollectionViewCell
            cell.cuisineLabel.text = restaurantSelected.cuisine
            cell.ratingsLabel.text = "Rating: \(restaurantSelected.rating)"
            cell.waitingTimeLabel.text = "\(restaurantSelected.restWaitingTime) Mins"
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedItems", for: indexPath) as! FeaturedItemsCollectionViewCell
            cell.dishImageLabel.image = RestaurantController.shared.featuredMenu[indexPath.row].image
            cell.dishNameLabel.text = RestaurantController.shared.featuredMenu[indexPath.row].name
            cell.dishRatingLabel.text = RestaurantController.shared.formatRating(RestaurantController.shared.featuredMenu[indexPath.row].rating)
            cell.dish = RestaurantController.shared.featuredMenu[indexPath.row]
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Menu", for: indexPath) as! MenuCollectionViewCell
            cell.dishImage.image = RestaurantController.shared.dish[indexPath.row].image
            cell.dishName.text = RestaurantController.shared.dish[indexPath.row].name
            cell.dishRating.text = RestaurantController.shared.formatRating(RestaurantController.shared.dish[indexPath.row].rating)
            cell.dishDescription.text = RestaurantController.shared.dish[indexPath.row].description
            cell.dish = RestaurantController.shared.dish[indexPath.row]
            cell.dishPriceLabel.text = "₹ \(RestaurantController.shared.dish[indexPath.row].price)"
            //cell.index = indexPath.row
            if RestaurantController.shared.dish[indexPath.row].foodType == "Non-veg" {
                cell.foodCategoryLabel.backgroundColor = .red
                cell.foodCategoryLabel2.backgroundColor = .red
            }
            else {
                cell.foodCategoryLabel.backgroundColor = .systemGreen
                cell.foodCategoryLabel2.backgroundColor = .systemGreen
            }
            for dishinFavourite in RestaurantController.shared.favouriteDish {
                if RestaurantController.shared.dish[indexPath.row] == dishinFavourite {
                    cell.addToFavourites.isSelected = true
                }
            }

            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RestaurantDetails", for: indexPath)
            return cell
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = restaurantSelected.restName
        self.navigationController?.navigationBar.prefersLargeTitles = true

        Task.init {
            do {
                if let url = URL(string: "https://queueskipperbackend.onrender.com/get_all_product/\(restaurantSelected.restId)"){
                    
                    let list = try await NetworkUtils.shared.fetchDish(from: url)
                    print("DishesFetched")
                    print(list)
                    for var item in list {
                        if let url = URL(string: "https://queueskipperbackend.onrender.com/get_product_photo/\(item.dishId)") {
                            if let image = try? await NetworkUtils.shared.fetchImage(from: url) {
                                
                                item.image = image
                                RestaurantController.shared.appendDish(dish: item)
                                
                                
                            } else {
                                print("Failed to load image for dish:")
                            }
                        } else {
                            print("Invalid URL for dish: ")
                        }
                        if item.rating >= 4.0 {
                            if !RestaurantController.shared.featuredMenu.contains(item){
                                RestaurantController.shared.appendFeaturedMenu(dish: item)
                            }
                        }
                    }
//                    RestaurantController.shared.setDish(dish: list)
                    await MainActor.run {
                        self.collectionView.reloadData()
                    }
                }
            }
                catch {
                    print("error at home")
                }
    
        }
        let restaurantDetailNib = UINib(nibName: "RestaurantDetails", bundle: nil)
        collectionView.register(restaurantDetailNib, forCellWithReuseIdentifier: "RestaurantDetails")
        let featuredItemNib = UINib(nibName: "FeaturedItems", bundle: nil)
        collectionView.register(featuredItemNib, forCellWithReuseIdentifier: "FeaturedItems")
        let menuNib = UINib(nibName: "Menu", bundle: nil)
        collectionView.register(menuNib, forCellWithReuseIdentifier: "Menu")
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        let button: UIBarButtonItem = {
            let button = UIBarButtonItem(image: UIImage(systemName: "cart"), style:.plain, target: self, action: #selector(cartButtonTapped))
            button.tintColor = .systemGreen
                return button
            }()
        self.navigationItem.rightBarButtonItem = button
       
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollectionView), name: .favouritesUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateCollectionView), name: .cartUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: .cartUpdated, object: nil)
    }
    
    @objc func updateCollectionView() {
        collectionView.reloadData()
    }
    
    @objc func cartUpdated() {
        if RestaurantController.shared.cartDish.isEmpty {
                
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "cart")
            } else {
               
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "cart.fill")
            }
       }
    
    @objc func cartButtonTapped() {
        
        
        let storyboard = UIStoryboard(name: "MyCart", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
//        viewController.restaurantSelected = Restaurant()
        
        let navVC = self.navigationController
        self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
        navVC?.pushViewController(viewController, animated: true)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        cartUpdated()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
            
            headerView.headerLabel.text = RestaurantController.shared.sectionHeaders[indexPath.section]
            print(RestaurantController.shared.sectionHeaders[indexPath.section])
            //headerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 17)
            
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
    
  
    func generateLayout() ->UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout{
            (sectionIndex, env) -> NSCollectionLayoutSection? in let section: NSCollectionLayoutSection
            
            switch sectionIndex {
            case 0:
                section = self.generateSection0()
            case 1:
                section = self.generateSection1()
            case 2:
                section = self.generateSection2()
            default:
                section = self.generateSection0()
            }
            
            return section
        }
        return layout
    }
    
    func generateSection0() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func generateSection1() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.99), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func generateSection2() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
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
