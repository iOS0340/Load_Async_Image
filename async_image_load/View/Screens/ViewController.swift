//
//  ViewController.swift
//  async_image_load
//
//  Created by Bhavesh Patel on 15/04/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var progressView: UIView!
    
    @IBOutlet weak var tblView : UITableView!
    let viewModel : PhotosViewModel = PhotosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.register(UINib.init(nibName: "asyncImageTableCell", bundle: nil), forCellReuseIdentifier: "asyncImageCell")
        
        self.tblView.isHidden = true
        
        setFooterViewWithIndicator()
        checkLoadingEvent()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadPhotosFromServer()
    }
    
    func setFooterViewWithIndicator() {
        let indicator : UIActivityIndicatorView = UIActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        indicator.style = .large
        indicator.startAnimating()
        self.tblView.tableFooterView = indicator
    }
    
    func setFooterViewWithImageLoadedMessage() -> Void {
        let lbl = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        lbl.text = viewModel.photos.count == 0 ? LOADING : ALL_PHOTOS_LOADED
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        self.tblView.tableFooterView = lbl
    }
}


extension ViewController {
    func loadPhotosFromServer () {
        viewModel.fetchPhotosFromServer()
    }
    
    func checkLoadingEvent () {
        viewModel.event = { event in
            switch event {
            case .loading:
                print("Loading....")
                break
            case .stopLoading:
                print("Stop Loading....")
                break
            case .loaded:
                DispatchQueue.main.async {
                    self.tblView.isHidden = false
                    self.tblView.reloadData()
                    print("Loaded....")
                }
                break
            case .allImagesLoaded:
                DispatchQueue.main.async {
                    self.setFooterViewWithImageLoadedMessage()
                }
                break
            case .failure(let error, let errorCode):
                switch error {
                case .noInternet:
                    self.handleError(error: error!, statusCode: errorCode!)
                    break;
                case .invalidURL:
                    self.showErrorMessage(message: CHECK_URL)
                    break
                case .noDataFound:
                    self.showErrorMessage(message: DATA_NOT_FOUND)
                    break
                case .authenticationFailed:
                    self.showErrorMessage(message: AUTH_FAIL)
                    break
                case .invalidResponse(let statusCode):
                    self.handleError(error: error! , statusCode: statusCode!)
                case .invalidData:
                    self.showErrorMessage(message: INVALID_DATA)
                    break
                case .networkError(let error, let statusCode):
                    self.handleError(error: error as! BHError, statusCode: statusCode!)
                    break
                case .none:
                    break
                }
                
                break
            }
        }
    }
    
    func handleError (error : BHError, statusCode : Int) -> Void {
        if (500...599 ~= statusCode) {
            showErrorMessage(message: SERVER_NOT_FOUND)
        }
        else if (400...499 ~= statusCode) {
            if (statusCode == 404) {
                showErrorMessage(message: API_NOT_FOUND)
            }
            else if (statusCode == 401) {
                showErrorMessage(message: UNAUTH_USER)
            }
            else {
                print("API response Error \(error) and Status Code \(statusCode)")
                showErrorMessage(message: SOME_WENT_WRONG)
            }
        }
        else if (700... ~= statusCode) {
            
            
                showErrorMessage(message: SOME_WENT_WRONG)
            
            
        }
        else {
            if (statusCode == -1009) {
                DispatchQueue.main.async {
                    AppDelegate.sharedObj.showErrorMessage(message: NO_INTERNET)
                }
            }
            else {
                showErrorMessage(message: SOME_WENT_WRONG)
            }
        }
    }
    
    func showErrorMessage (message : String) -> Void{
        DispatchQueue.main.async {
            AppDelegate.sharedObj.showErrorMessage(message: message)
            self.perform(#selector(self.removeErrorViewAfterDelay), with: nil, afterDelay: 4)
        }
    }
    
    @objc func removeErrorViewAfterDelay () {
        DispatchQueue.main.async {
            AppDelegate.sharedObj.removeErrorMessage();
        }
    }
}

extension ViewController : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "asyncImageCell", for: indexPath) as! AsyncImageTableCell
        
        /**
         This code is to check fail Image load and set failed Image placeholder scenario.
         
         if (indexPath.row == 2) {
         viewModel.photos[2].urls.thumb = "images.unsplash.com/photo-1711968558537";
         }
         
         */
        cell.photo = viewModel.photos[indexPath.row]
        return cell;
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (viewModel.photos.count > 0 && indexPath.row == viewModel.photos.count - 2){            
            loadPhotosFromServer()
        }
    }
}
