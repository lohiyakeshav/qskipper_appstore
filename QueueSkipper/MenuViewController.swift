//
//  MenuViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 17/05/24.
//

import UIKit

class MenuViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    var restaurant: Restaurant
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    init?(coder: NSCoder, restaurant: Restaurant) {
        self.restaurant = restaurant
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (restaurant.dish.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        
            
            
            if let label1 = cell.contentView.viewWithTag(1) as? UILabel {
                label1.text = restaurant.dish[indexPath.row].name
            }
            if let label2 = cell.contentView.viewWithTag(2) as? UILabel {
                label2.text = restaurant.dish[indexPath.row].description
            }
            if let label3 = cell.contentView.viewWithTag(3) as? UILabel {
                label3.text = "\u{20b9}" + (String(describing: restaurant.dish[indexPath.row].price))
                
            }
            if let image = cell.contentView.viewWithTag(4) as? UIImageView {
                image.image = UIImage(named: String(describing: restaurant.dish[indexPath.row].image))
            }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = restaurant.restName

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 393, height: 150)
    }

}
