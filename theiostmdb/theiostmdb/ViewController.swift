//
//  ViewController.swift
//  theiostmdb
//
//  Created by aitor pagan  on 10/3/17.
//
//

import UIKit

class ViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    
    let ai: UIActivityIndicatorView? = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    let separation: CGFloat = 50.0
    var frame: CGRect = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 100.0)
    var tableView: UITableView? = UITableView()
    let filmViewModel: FilmViewModel = FilmViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ai?.frame = CGRect(x: 0.0, y: 300, width: self.view.frame.size.width, height: 100)
        self.view.backgroundColor = UIColor.black
        self.view.reloadInputViews()
        self.tableView = UITableView.init(frame: self.view.frame)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.register(FilmViewCell.classForCoder(), forCellReuseIdentifier: "filmCell")
        self.view.addSubview(self.tableView!)
        self.view.addSubview(ai!)
        ai?.color = UIColor.black
        ai!.startAnimating()
        self.filmViewModel.fetchDiscoverFilms(completion: {Void in
                self.ai!.stopAnimating()
                self.ai!.removeFromSuperview()
                self.tableView?.reloadData()
        }, errorHandler: {error in
            self.ai!.stopAnimating()
            self.ai?.removeFromSuperview()
            self.showErrorAlert(with: error)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as! FilmViewCell
        if filmViewModel.numberOfRowsInSection(section: 1) > 0{
            cell.overview?.text = self.filmViewModel.getTextForOverview(at: indexPath.section)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return filmViewModel.numberOfRowsInSection(section: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return CGFloat(self.filmViewModel.getTextForOverview(at: indexPath.section).lengthOfBytes(using: .utf8))
    }


}

