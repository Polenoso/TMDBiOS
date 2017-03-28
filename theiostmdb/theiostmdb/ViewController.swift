//
//  ViewController.swift
//  theiostmdb
//
//  Created by aitor pagan  on 10/3/17.
//
//

import UIKit



class ViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    
    var completion: (() -> Void)? = nil
    var error: ((String) -> Void)? = nil

    let separation: CGFloat = 50.0
    var frame: CGRect = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 100.0)
    var tableView: UITableView? = UITableView()
    let filmViewModel: FilmViewModel = FilmViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.reloadInputViews()
        self.tableView = UITableView.init(frame: self.view.frame)
        self.tableView?.backgroundColor = UIColor.white
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.register(FilmViewCell.classForCoder(), forCellReuseIdentifier: "filmCell")
        self.tableView?.separatorStyle = .none
        self.view.addSubview(self.tableView!)
        completion = {Void in
            self.stopActivityIndicator()
            self.tableView?.reloadData()
        }
        error = {error in
            self.stopActivityIndicator()
            self.showErrorAlert(with: error)
        }
        startActivityIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(true)
        self.filmViewModel.fetchDiscoverFilms(completion: self.completion!, errorHandler: self.error!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as! FilmViewCell
        if filmViewModel.numberOfRowsInSection(section: 1) > 0{
            cell.overview?.text = self.filmViewModel.getTextForOverview(at: indexPath.section)
            NetworkService.shared.requestImage(path: self.filmViewModel.getPathForImage(at: indexPath.section), completionHandler: {image in
                cell.photo?.image = image
            })
            cell.overview?.sizeToFit()
            cell.reloadInputViews()
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
        return FilmViewCell.heightForCell(with: self.filmViewModel.getTextForOverview(at: indexPath.section))
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return separation
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section < filmViewModel.numberOfRowsInSection(section: 1) - 1 ? 0.0 : 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let loadingView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loadingView.color = UIColor.black
        loadingView.startAnimating()
        return section < filmViewModel.numberOfRowsInSection(section: 1) - 1 ? nil : loadingView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let nextPage: Bool = filmViewModel.numberOfRowsInSection(section: 1) - 1 <= indexPath.section
        if(nextPage){
            filmViewModel.fetchDiscoverFilms(completion:self.completion!, errorHandler: self.error!)
        }
    }

}

