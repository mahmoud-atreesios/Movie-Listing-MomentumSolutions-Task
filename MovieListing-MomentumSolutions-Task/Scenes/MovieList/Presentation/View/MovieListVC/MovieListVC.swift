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
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    @IBOutlet weak var recommendedMoviesCollectionView: UICollectionView!
    
    @IBOutlet weak var topSearchesMoviesTableView: UITableView!
    
    private var viewModel: MovieListViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    private let bannerImages: [String] = ["movie2", "movie3", "movie11"]
    private var currentPage: Int = 0
    private var timer: Timer?
    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBannerCollectionView()
        setupMoviesCollectionView()
        setupTableView()
        setupBindings()
        viewModel.fetchMovies()
        setupPageControl()
        startBannerScrolling()
        
    }
    
    @IBAction func pageControlChanged(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        let indexPath = IndexPath(item: currentPage, section: 0)
        bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.currentPage = currentPage
    }
    
}

//MARK: - Setup
extension MovieListVC {
    
    // Register the custom Banner collection view cell
    private func setupBannerCollectionView() {
        let bannerNib = UINib(nibName: "BannerCollectionViewCell", bundle: nil)
        bannerCollectionView.register(bannerNib, forCellWithReuseIdentifier: "bannerCollectionViewCell")
        
        bannerCollectionView.dataSource = self
        bannerCollectionView.delegate = self
    }
    
    // Register the custom Movies collection view cell
    private func setupMoviesCollectionView() {
        let nib = UINib(nibName: "RecommendedMoviesCollectionViewCell", bundle: nil)
        recommendedMoviesCollectionView.register(nib, forCellWithReuseIdentifier: "recommendedMovieCollectionCell")
        
        recommendedMoviesCollectionView.dataSource = self
        recommendedMoviesCollectionView.delegate = self
    }
    
    // Register the custom table view cell
    private func setupTableView() {
        let tableNib = UINib(nibName: "TopSearchMoviesTableViewCell", bundle: nil)
        topSearchesMoviesTableView.register(tableNib, forCellReuseIdentifier: "topSearchMoviesTableViewCell")
        
        topSearchesMoviesTableView.dataSource = self
        topSearchesMoviesTableView.delegate = self
    }
    
    // setup page control
    private func setupPageControl() {
        pageControl.numberOfPages = bannerImages.count
        pageControl.currentPage = 0
    }
    
    // setup binding
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
}

//MARK: - Override function
extension MovieListVC {
    override func viewDidLayoutSubviews() {
        personImageView.setCornerRadius(60)
        //bannerImageView.setCornerRadius(20)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        startBannerScrolling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        timer?.invalidate()
    }
}

//MARK: - Collection View Cell
extension MovieListVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bannerCollectionView {
            return bannerImages.count
        }
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.bannerImageView.image = UIImage(named: bannerImages[indexPath.item])
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "recommendedMovieCollectionCell",
            for: indexPath
        ) as? RecommendedMoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = viewModel.movies[indexPath.item]
        cell.configure(with: movie)
        
        cell.onFavoriteTapped = { [weak self] in
            self?.viewModel.toggleFavorite(for: movie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == recommendedMoviesCollectionView {
            let movie = viewModel.movies[indexPath.item]
            let detailsVC = MovieDetailsVC(movie: movie, viewModel: viewModel)
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bannerCollectionView {
            return bannerCollectionView.bounds.size
        }
        return CGSize(width: 150, height: 240)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == bannerCollectionView {
            let width = scrollView.frame.size.width
            currentPage = Int(scrollView.contentOffset.x / width)
            pageControl.currentPage = currentPage
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.movies[indexPath.row]
        let detailsVC = MovieDetailsVC(movie: movie, viewModel: viewModel)
        navigationController?.pushViewController(detailsVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - Handle Banner Logic
extension MovieListVC {
    private func startBannerScrolling() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let nextPage = (self.currentPage + 1) % self.bannerImages.count
            let indexPath = IndexPath(item: nextPage, section: 0)
            self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.pageControl.currentPage = nextPage
            self.currentPage = nextPage
        }
    }
}
