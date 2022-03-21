//
//  ViewController.swift
//  WeatherApp
//
//  Created by Bruno Frani on 1.3.22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
  
  private let viewModel: HomeViewModel
  private let dependecies: AppDependencies
  private var childView: HomeView!
  private var subscriptions = Set<AnyCancellable>()
  
  init(dependecies: AppDependencies) {
    let viewModel = HomeViewModel(dependencies: dependecies)
    self.viewModel = viewModel
    self.dependecies = dependecies
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let homeView = HomeView()
    childView = homeView
    view = childView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    childView.collectionView.delegate = self
    bindViewModel()
    viewModel.getLocalCities()
    navigationItem.title = "Cities"
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
    navigationItem.rightBarButtonItem = addButton
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    //    viewModel.getCities()
  }
  
  private func bindViewModel() {
    viewModel.$state.sink { [weak self] state in
      self?.updateViewForState(state)
    }.store(in: &subscriptions)
  }
  
  private func updateViewForState(_ state: ViewModelState) {
    switch state {
    case .initial:
      break
    case .loading:
      displayAnimatedActivityIndicatorView()
    case .data(let cities):
      guard let cities = cities as? [City] else { return }
      applySnapshot(data: cities)
      hideAnimatedActivityIndicatorView()
    case .empty:
      applySnapshot(data: [])
      hideAnimatedActivityIndicatorView()
    case .error(let error):
      hideAnimatedActivityIndicatorView()
      showAlert(alertText: "Error", alertMessage: error.localizedDescription.description, buttonText: "Ok")
    }
  }
  
  private func applySnapshot(data: [City]) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, City>()
    snapshot.appendSections([1])
    snapshot.appendItems(data, toSection: 1)
    childView.diffableDataSource.apply(snapshot)
  }
  
  @objc private func addPressed() {
    let searchCityViewController = SearchCityViewController(dependecies: dependecies)
    self.navigationController?.pushViewController(searchCityViewController, animated: true)
  }
}

extension HomeViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    switch viewModel.state {
    case .data(value: let cities):
      guard let cities = cities as? [City], let woeid = cities[indexPath.row].woeid else { return }
      let cityViewController = CityViewController(dependecies: dependecies, woeid: woeid)
      navigationController?.pushViewController(cityViewController, animated: true)
    default:
      break
    }
  }
}
