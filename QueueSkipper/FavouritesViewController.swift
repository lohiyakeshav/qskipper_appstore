//
//  FavouritesViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 16/05/24.
//

import UIKit

class FavouritesViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.tabBarItem.title = "Favourites"
        self.tabBarItem.image = UIImage(systemName: "heart")
        self.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RestaurantController.shared.favouriteDish.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //print(favouriteDish)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Menu", for: indexPath) as! MenuCollectionViewCell
        cell.dishImage.image = RestaurantController.shared.favouriteDish[indexPath.row].image
        cell.dishName.text = RestaurantController.shared.favouriteDish[indexPath.row].name
        cell.dishDescription.text = RestaurantController.shared.favouriteDish[indexPath.row].description
        cell.dishRating.text = RestaurantController.shared.formatRating(RestaurantController.shared.favouriteDish[indexPath.row].rating)
        cell.dishPriceLabel.text = "₹\(RestaurantController.shared.favouriteDish[indexPath.row].price)"
        cell.dish = RestaurantController.shared.favouriteDish[indexPath.row]
        cell.addToFavourites.isSelected = true
        if RestaurantController.shared.favouriteDish[indexPath.row].foodType == "Non-veg" {
            cell.foodCategoryLabel.backgroundColor = .red
            cell.foodCategoryLabel2.backgroundColor = .red
        }
        else {
            cell.foodCategoryLabel.backgroundColor = .systemGreen
            cell.foodCategoryLabel2.backgroundColor = .systemGreen
        }

        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let favouriteNib = UINib(nibName: "Menu", bundle: nil)
        collectionView.register(favouriteNib, forCellWithReuseIdentifier: "Menu")
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        
    }
    
    
    func generateLayout() ->UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout{
            (section, env) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
            
        }
        return layout
    }


}
