//
//  ThreeVC.swift
//  AnimatedCustomTransition
//
//  Created by Mostafa Abd ElFatah on 5/21/21.
//
//

import UIKit

final class ThreeVC: UIViewController {

    // MARK: - Public static properties -
    public static var instance:ThreeVC {
        let  mainStory = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStory.instantiateViewController(withIdentifier: "ThreeVC") as! ThreeVC
        return vc
    }
    // MARK: - Public properties -

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    // MARK: - Private properties -
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        hero.isEnabled = true
        imageView.hero.id = "imageView"
        searchView.hero.id = "searchView"
    }

    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true)
    }
}

// MARK: - Extensions -
extension ThreeVC {
    
}
