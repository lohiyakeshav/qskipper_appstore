//
//  MenuViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 17/05/24.
//

import UIKit


class MenuViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var restaurant: Restaurant
    

    
    var restaurantSelected: Restaurant
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    init?(coder: NSCoder, restaurantSelected: Restaurant, restaurant: Restaurant) {
        self.restaurantSelected = restaurantSelected
        self.restaurant = restaurant
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            //return Menu.featuredItems.count
            return restaurantSelected.dish.count
        case 2:
            //return Menu.dish.count
            return restaurantSelected.dish.count
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
            cell.dishImageLabel.image = UIImage(named: restaurantSelected.dish[indexPath.row].image)
            cell.dishNameLabel.text = restaurantSelected.dish[indexPath.row].name
            cell.dishRatingLabel.text = "\(restaurantSelected.dish[indexPath.row].rating)"
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Menu", for: indexPath) as! MenuCollectionViewCell
            cell.dishImage.image = UIImage(named: restaurantSelected.dish[indexPath.row].image)
            cell.dishName.text = restaurantSelected.dish[indexPath.row].name
            cell.dishRating.text = "\(restaurantSelected.dish[indexPath.row].rating)"
            cell.dishDescription.text = restaurantSelected.dish[indexPath.row].description
            cell.dish = restaurantSelected.dish[indexPath.row]
            //cell.index = indexPath.row
            for dishinFavourite in favouriteDish {
                if restaurantSelected.dish[indexPath.row] == dishinFavourite {
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

        let restaurantDetailNib = UINib(nibName: "RestaurantDetails", bundle: nil)
        collectionView.register(restaurantDetailNib, forCellWithReuseIdentifier: "RestaurantDetails")
        let featuredItemNib = UINib(nibName: "FeaturedItems", bundle: nil)
        collectionView.register(featuredItemNib, forCellWithReuseIdentifier: "FeaturedItems")
        let menuNib = UINib(nibName: "Menu", bundle: nil)
        collectionView.register(menuNib, forCellWithReuseIdentifier: "Menu")
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //collectionView.reloadData()
    }
    
  
    func generateLayout() ->UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout{
            (section, env) -> NSCollectionLayoutSection? in
            
            switch section {
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                return section
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            default:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
        return layout
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
