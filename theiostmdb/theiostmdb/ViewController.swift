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
    var search: Bool = false
    let separation: CGFloat = 50.0
    var frame: CGRect = CGRect(x: 0.0, y: 0.0, width: 300.0, height: 100.0)
    var tableView: UITableView? = UITableView()
    let filmViewModel: FilmViewModel = FilmViewModel()
    var loadingError: Bool = false
    
    @IBOutlet var searchBar: UISearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.reloadInputViews()
        var tableFrame: CGRect
        if(search){
            searchBar?.frame = CGRect(origin: CGPoint(x: 0.0, y: (navigationController?.navigationBar.frame.origin.y)! + (navigationController?.navigationBar.frame.size.height)!), size: (searchBar?.frame.size)!)
            self.view.addSubview(searchBar!)
            tableFrame = CGRect(x: self.view.frame.origin.x, y: (searchBar?.frame.origin.y)! + (searchBar?.frame.size.height)!, width: self.view.frame.size.width, height: self.view.frame.size.height - ((searchBar?.frame.origin.y)! + (searchBar?.frame.size.height)!))
        }else{
            tableFrame = self.view.frame
        }
        self.tableView = UITableView.init(frame: tableFrame)
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
            self.tableView?.reloadData()
            self.showErrorAlert(with: error)
        }
        if(!search){startActivityIndicator()}
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(true)
        if(!search) {self.filmViewModel.fetchDiscoverFilms(completion: self.completion!, errorHandler: self.error!)}
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
        return ((section < filmViewModel.numberOfRowsInSection(section: 1) - 1) || loadingError) ? nil : loadingView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let nextPage: Bool = filmViewModel.numberOfRowsInSection(section: 1) - 1 <= indexPath.section
        if(nextPage && !filmViewModel.isLoading && !self.loadingError){
            switch search {
            case true:
                filmViewModel.fetchSearchFilms(query:(searchBar?.text)!, completion:self.completion!, errorHandler: {error in
                    self.loadingError = true
                    tableView.reloadSections([indexPath.section], with: .bottom)
                })
                break
            case false:
                filmViewModel.fetchDiscoverFilms(completion:self.completion!, errorHandler: {error in
                    self.loadingError = true
                    tableView.reloadSections([indexPath.section], with: .none)
                })
                break
            }
            
        }
    }

}

