//
//  ViewController.swift
//  DonutGenerator
//
//  Created by FIT1039MAC on 2024/8/2.
//

import UIKit
import FoodTruckKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var doughImageView: UIImageView!
    @IBOutlet weak var glazeImageView: UIImageView!
    @IBOutlet weak var toppingImageView: UIImageView!
    @IBOutlet weak var donutSegmentControl: UISegmentedControl!
    
    @IBOutlet weak var tableview: UITableView!
    var currentTableView: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTableView = 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell")
        
        
        switch donutSegmentControl.selectedSegmentIndex {
        case 0:
            cell?.textLabel?.text = mapDoughToNames(doughs: Donut.Dough.all)[indexPath.row]
            
        case 1:
            cell?.textLabel?.text = mapGlazeToNames(glazes: Donut.Glaze.all)[indexPath.row]

        case 2:
            cell?.textLabel?.text = mapToppingToNames(toppings: Donut.Topping.all)[indexPath.row]

        default:
            cell?.textLabel?.text = mapDoughToNames(doughs: Donut.Dough.all)[indexPath.row]
        }
        
        
        return cell!
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
        tableview.reloadData()

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



#Preview {
    return UIStoryboard(name: "Main", bundle: nil)
        .instantiateInitialViewController()!
}

