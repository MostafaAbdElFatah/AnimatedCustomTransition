//
//  SecondVC.swift
//  AnimatedCustomTransition
//
//  Created by Mostafa Abd ElFatah on 5/21/21.
//
//

import UIKit

final class SecondVC: UIViewController {

    
    // MARK: - Public static properties -
    public static var instance:SecondVC {
        let  mainStory = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStory.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        return vc
    }
    // MARK: - Public properties -
    @IBOutlet weak var sView: UIView!
    @IBOutlet weak var dismissBtn: UIButton!
    // MARK: - Private properties -
    let transition = AnimationManager()
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissBtn.layer.cornerRadius = dismissBtn.bounds.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func dismissBtnTapped(_ sender: UIButton) {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - Extensions -
extension SecondVC {
    
}


fileprivate func degreesToRadians(_ degrees: CGFloat) -> CGFloat {
  return degrees / 180.0 * CGFloat(Double.pi)
}

fileprivate func radiansToDegrees(_ radians: CGFloat) -> CGFloat {
  return radians * 180.0 / CGFloat(Double.pi)
}
