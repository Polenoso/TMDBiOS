//
//  ViewController.swift
//  theiostmdb
//
//  Created by davidjose gutierrez calderon  on 10/3/17.
//
//

import UIKit

class ViewController: UIViewController {
    
    let ai: UIActivityIndicatorView? = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    let separation: CGFloat = 50.0
    var frame: CGRect = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 100.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ai?.frame = CGRect(x: 0.0, y: 300, width: self.view.frame.size.width, height: 100)
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(ai!)
        ai?.color = UIColor.white
        ai!.startAnimating()
        self.view.reloadInputViews()
        NetworkService.shared.discoverMovies(page: 1, completionHandler: {response in
            if let response = response as? [Film]{
                self.ai!.stopAnimating()
                self.ai?.removeFromSuperview()
                for film in response{
                    let newFilm = UILabel(frame: self.frame)
                    newFilm.text = film.overview
                    newFilm.textColor = UIColor.white
                    self.view.addSubview(newFilm)
                    self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.separation, width: self.frame.size.width, height: self.frame.size.height)
                    self.view.reloadInputViews()
                }
                
            }
        }, errorHandler: {error in
            NSLog(error)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

