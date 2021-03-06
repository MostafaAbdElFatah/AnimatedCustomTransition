//
//  ViewController.swift
//  AnimatedCustomTransition
//
//  Created by Mostafa Abd ElFatah on 5/21/21.
//

import UIKit
import SparkUI

class FirstVC: UIViewController {
    
    let transition = AnimationManager()
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuBtn.layer.cornerRadius = menuBtn.bounds.size.height / 2
        
        imageView.hero.id = "imageView"
        searchView.hero.id = "searchView"
        searchView.add(gesture: Gesture.tap(1)) { (view) in
            let vc = ThreeVC.instance
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func menuBtnTapped(_ sender: UIButton) {
       
    }
    
    // with CircularTransition animation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! SecondVC
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
    }
}

extension FirstVC: UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .present
        transition.startingPoint = menuBtn.center
        transition.circleColor = menuBtn.backgroundColor!

        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.transitionMode = .dismiss
        transition.startingPoint = menuBtn.center
        transition.circleColor = menuBtn.backgroundColor!

        return transition
    }
}


extension FirstVC:UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            transition.transitionMode = .present
            transition.startingPoint = menuBtn.center
            transition.circleColor = menuBtn.backgroundColor!
            
            return transition
        case .pop:
            transition.transitionMode = .dismiss
            transition.startingPoint = menuBtn.center
            transition.circleColor = menuBtn.backgroundColor!
            
            return transition
        default:
            return nil
        }
        
    }
    
}

//
//extension UIButton{
//
//    func title(_ title:String) -> UIButton {
//        self.setTitle( title, for: .normal)
//        return self
//    }
//
//    func titleColor(_ color:UIColor) -> UIButton {
//        self.setTitleColor( color, for: .normal)
//        return self
//    }
//
//    func background(_ color:UIColor) -> UIButton {
//        self.backgroundColor = color
//        return self
//    }
//
//    func cornerRadius(_ cornerRadius:CGFloat) -> UIButton {
//        self.layer.cornerRadius = cornerRadius
//        return self
//    }
//
//}
