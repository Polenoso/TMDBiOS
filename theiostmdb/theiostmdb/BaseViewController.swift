//
//  BaseViewController.swift
//  theiostmdb
//
//  Created by aitor pagan  on 14/3/17.
//
//

import UIKit

@objc
protocol CenterViewControllerDelegate {
    @objc optional func toggleLeftPanel()
    @objc optional func showViewController(vc: UIViewController)
}

class BaseViewController: UIViewController {
    
    var delegate: CenterViewControllerDelegate?
    
    var alertController: UIAlertController? = nil
    let alertHeight:CGFloat = 100.0
    let alertWidth:CGFloat = 300.0
    let ai: UIActivityIndicatorView? = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ai?.frame = CGRect(x: 0.0, y: 300, width: self.view.frame.size.width, height: 100)
        let menuButton: UIBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(BaseViewController.toggleMenu(sender:)))
        self.navigationItem.setLeftBarButton(menuButton, animated: false)
        self.navigationItem.title = "TMDB"
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
    
    func startActivityIndicator(){
        self.view.addSubview(ai!)
        ai?.color = UIColor.black
        ai!.startAnimating()
    }
    
    func stopActivityIndicator(){
        self.ai!.stopAnimating()
        self.ai!.removeFromSuperview()
    }
    
    func toggleMenu(sender: UIBarButtonItem){
        dismissKeyboard()
        delegate?.toggleLeftPanel!()
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
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

extension BaseViewController: SidePanelViewControllerDelegate{
    func optionSelected(vc: UIViewController) {
        if(self.ai?.isAnimating)!{
            self.stopActivityIndicator()
            NetworkService.shared.stopRequests();
        }
        delegate?.showViewController!(vc: vc)
        delegate?.toggleLeftPanel!()
    }
}
