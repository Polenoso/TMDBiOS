//
//  BaseViewController.swift
//  theiostmdb
//
//  Created by aitor pagan  on 14/3/17.
//
//

import UIKit

class BaseViewController: UIViewController {
    
    var alertController: UIAlertController? = nil
    let alertHeight:CGFloat = 100.0
    let alertWidth:CGFloat = 300.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showErrorAlert(with message: String){
        self.alertController = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
        self.alertController?.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: nil))
        self.present(self.alertController!, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
