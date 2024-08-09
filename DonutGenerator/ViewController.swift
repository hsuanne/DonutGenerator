//
//  ViewController.swift
//  DonutGenerator
//
//  Created by FIT1039MAC on 2024/8/2.
//

import UIKit
import FoodTruckKit

class ViewController: UIViewController {
    @IBOutlet weak var doughImageView: UIImageView!
    @IBOutlet weak var glazeImageView: UIImageView!
    @IBOutlet weak var toppingImageView: UIImageView!
    @IBOutlet weak var donutSegmentControl: UISegmentedControl!
    @IBOutlet weak var gridCollectionView: UICollectionView!
    var currentTableView: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTableView = 0
    }
    
    func setupCollectionView() {
        gridCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        gridCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    func mapDoughToNames(doughs: [Donut.Dough]) -> [String] {
        return doughs.map {$0.name}
    }
    
    func mapGlazeToNames(glazes: [Donut.Glaze]) -> [String] {
        return glazes.map {$0.name}
    }
    
    func mapToppingToNames(toppings: [Donut.Topping]) -> [String] {
        return toppings.map {$0.name}
    }
        
    @IBAction func onSegmentPressed(_ sender: Any) {
        currentTableView = donutSegmentControl.selectedSegmentIndex
        gridCollectionView.reloadData()
    }
    
    
    @IBAction func createRandomDonut(_ sender: Any) {
        doughImageView.image = getRandomDough().uiImage(thumbnail: false)
        glazeImageView.image = getRandomGlaze().uiImage(thumbnail: false)
        toppingImageView.image = getRandomTopping().uiImage(thumbnail: false)
    }
    
    func getRandomDough() -> Donut.Dough {
        let doughs = Donut.Dough.all
        return doughs.randomElement() ?? Donut.Dough.plain
    }
    
    func getRandomGlaze() -> Donut.Glaze {
        let glazes = Donut.Glaze.all
        return glazes.randomElement() ?? Donut.Glaze.rainbow
    }
    
    func getRandomTopping() -> Donut.Topping {
        let toppings = Donut.Topping.all
        return toppings.randomElement() ?? Donut.Topping.sprinkles
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch donutSegmentControl.selectedSegmentIndex {
        case 0:
            return Donut.Dough.all.count
            
        case 1:
            return Donut.Glaze.all.count

        case 2:
            return Donut.Topping.all.count

        default:
            return Donut.Dough.all.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        switch donutSegmentControl.selectedSegmentIndex {
        case 0:
            cell.donutLabel.text = mapDoughToNames(doughs: Donut.Dough.all)[indexPath.row]
            cell.donutThumbnail.image = Donut.Dough.all[indexPath.row].uiImage(thumbnail: false)
            
        case 1:
            cell.donutLabel.text = mapGlazeToNames(glazes: Donut.Glaze.all)[indexPath.row]
            cell.donutThumbnail.image = Donut.Glaze.all[indexPath.row].uiImage(thumbnail: false)

        case 2:
            cell.donutLabel.text = mapToppingToNames(toppings: Donut.Topping.all)[indexPath.row]
            cell.donutThumbnail.image = Donut.Topping.all[indexPath.row].uiImage(thumbnail: false)

        default:
            cell.donutLabel.text = mapDoughToNames(doughs: Donut.Dough.all)[indexPath.row]
        }
            
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemNum = indexPath.row
                
        switch donutSegmentControl.selectedSegmentIndex {
        case 0:
            doughImageView.image = Donut.Dough.all[itemNum].uiImage(thumbnail: false)
            
        case 1:
            glazeImageView.image = Donut.Glaze.all[itemNum].uiImage(thumbnail: false)

        case 2:
            toppingImageView.image = Donut.Topping.all[itemNum].uiImage(thumbnail: false)

        default:
            doughImageView.image = Donut.Dough.all[itemNum].uiImage(thumbnail: false)
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = (collectionView.frame.size.width - 10)/3
//        return CGSize(width: size, height: size)
//    }
    
}


#Preview {
    return UIStoryboard(name: "Main", bundle: nil)
        .instantiateInitialViewController()!
}

