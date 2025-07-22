//
//  MovieListVC.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//

import UIKit

class MovieListVC: UIViewController {
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var recommendedMoviesCollectionView: UICollectionView!
    
    @IBOutlet weak var topSearchesMoviesTableView: UITableView!
    
    let networkProvider = NetworkProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkProvider.get(apiEndpoint: FetchPopularMoviesRequest(), modelDto: PopularMoviesDTO.self) { result in
            switch result {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error)
            }
        }

        navigationController?.setNavigationBarHidden(true, animated: false)

        // Register the custom collection view cell
        let nib = UINib(nibName: "RecommendedMoviesCollectionViewCell", bundle: nil)
        recommendedMoviesCollectionView.register(nib, forCellWithReuseIdentifier: "recommendedMovieCollectionCell")

        recommendedMoviesCollectionView.dataSource = self
        recommendedMoviesCollectionView.delegate = self
        
        // Register the custom table view cell
        let tableNib = UINib(nibName: "TopSearchMoviesTableViewCell", bundle: nil)
        topSearchesMoviesTableView.register(tableNib, forCellReuseIdentifier: "topSearchMoviesTableViewCell")

        topSearchesMoviesTableView.dataSource = self
        topSearchesMoviesTableView.delegate = self

    }

    
    override func viewDidLayoutSubviews() {
        personImageView.setCornerRadius(60)
        bannerImageView.setCornerRadius(20)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

//MARK: - Collection View Cell
extension MovieListVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "recommendedMovieCollectionCell",
            for: indexPath
        ) as? RecommendedMoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 240)
    }
    
}

//MARK: - Table View Cell
extension MovieListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "topSearchMoviesTableViewCell", for: indexPath) as? TopSearchMoviesTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }

//    // Optional: Set cell height
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120 // Match your cell design
//    }
}
