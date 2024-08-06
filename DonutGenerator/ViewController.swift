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
    @IBOutlet weak var debugLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugLabel.text = "000"
    }
    
    
    @IBAction func onSegmentPressed(_ sender: Any) {
        switch donutSegmentControl.selectedSegmentIndex {
        case 0:
            debugLabel.text = "0"
            
        case 1:
            debugLabel.text = "1"
            
        case 2:
            debugLabel.text = "2"
            
        default:
            debugLabel.text = ""
        }
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

