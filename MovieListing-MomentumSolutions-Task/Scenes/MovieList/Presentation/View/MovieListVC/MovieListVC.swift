//
//  MovieListVC.swift
//  MovieListing-MomentumSolutions-Task
//
//  Created by Mahmoud Mohamed Atrees on 21/07/2025.
//

import UIKit
import Combine

class MovieListVC: UIViewController {
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var recommendedMoviesCollectionView: UICollectionView!
    
    @IBOutlet weak var topSearchesMoviesTableView: UITableView!
    
    private var viewModel: MovieListViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        
        viewModel.fetchMovies()
                
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
    
    private func setupBindings() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.recommendedMoviesCollectionView.reloadData()
                self?.topSearchesMoviesTableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .compactMap { $0 }
            .sink { error in
                print("Error fetching movies: \(error)")
            }
            .store(in: &cancellables)
    }
    
    override func viewDidLayoutSubviews() {
        personImageView.setCornerRadius(60)
        bannerImageView.setCornerRadius(20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

//MARK: - Collection View Cell
extension MovieListVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "recommendedMovieCollectionCell",
            for: indexPath
        ) as? RecommendedMoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = viewModel.movies[indexPath.item]
        cell.configure(with: movie)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.item]
        let detailsVC = MovieDetailsVC(movie: movie)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 240)
    }
    
}

//MARK: - Table View Cell
extension MovieListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "topSearchMoviesTableViewCell", for: indexPath) as? TopSearchMoviesTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = viewModel.movies[indexPath.item]
        cell.configure(with: movie)
        
        return cell
    }
}
