//
//  FavouritesViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 16/05/24.
//

import UIKit

class FavouritesViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var favouriteDish: [Dish] = [Dish(image: "big_2", name: "Samosa", description: "Potato Dish", price: 17, rating: 4.1, foodType: "Veg", favourites: true), Dish(image: "big_3", name: "Bread Pakora", description: "Indian Bread Dish", price: 30, rating: 3.6, foodType: "Veg", favourites: false), Dish(image: "big_3", name: "Pizza", description: "Italian Dish", price: 120, rating: 4.0, foodType: "Veg", favourites: true), Dish(image: "big_1", name: "Omelete", description: "Egg Dish", price: 50, rating: 3.4, foodType: "Non-Veg", favourites: false), Dish(image: "big_1", name: "Dosa", description: "South Indian Food", price: 80, rating: 3.9, foodType: "Veg", favourites: true), Dish(image: "big_2", name: "Idli Sambhar", description: "Rice Dish", price: 70, rating: 3.2, foodType: "Veg", favourites: false)]
    
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
        switch section {
        case 0:
            return favouriteDish.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Menu", for: indexPath) as! MenuCollectionViewCell
        cell.dishImage.image = UIImage(named: favouriteDish[indexPath.row].image)
        cell.dishName.text = favouriteDish[indexPath.row].name
        cell.dishDescription.text = favouriteDish[indexPath.row].description
        cell.dishRating.text = "\(favouriteDish[indexPath.row].rating)"
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let favouriteNib = UINib(nibName: "Menu", bundle: nil)
        collectionView.register(favouriteNib, forCellWithReuseIdentifier: "Menu")
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
