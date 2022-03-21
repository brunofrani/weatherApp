//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by Bruno Frani on 14.3.22.
//

import UIKit
import Combine

class SearchCityViewController: UIViewController {
  
  private let viewModel: SearchCityViewModel
  private let dependecies: AppDependencies
  private var childView: SearchCityView!
  private var subscriptions = Set<AnyCancellable>()
  
  init(dependecies: AppDependencies) {
    let viewModel = SearchCityViewModel(dependencies: dependecies)
    self.viewModel = viewModel
    self.dependecies = dependecies
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let searchCityView = SearchCityView()
    childView = searchCityView
    view = childView
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    childView.collectionView.delegate = self
    bindViewModel()
    navigationItem.title = "Add another city"
    let search = UISearchController(searchResultsController: nil)
    search.searchResultsUpdater = self
    search.obscuresBackgroundDuringPresentation = false
    search.searchBar.placeholder = "Search city by name"
    navigationItem.searchController = search
    navigationItem.hidesSearchBarWhenScrolling = false
  }
  
  private func bindViewModel() {
    viewModel.$state.sink { [weak self] state in
      self?.updateViewForState(state)
    }.store(in: &subscriptions)
    
    viewModel.$saved.sink { [weak self] saved in
      switch saved {
      case true:
        self?.navigationController?.popViewController(animated: true)
      case false:
        self?.showAlert(alertText: "Error", alertMessage: "A problem occoured while saving city", buttonText: "OK")
      default:
        break
      }
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
      childView.collectionView.isHidden = false
      childView.noDataLabel.isHidden = true
    case .empty:
      applySnapshot(data: [])
      hideAnimatedActivityIndicatorView()
      childView.collectionView.isHidden = true
      childView.noDataLabel.isHidden = false
    case .error(let error):
      hideAnimatedActivityIndicatorView()
      showAlert(alertText: "Error", alertMessage: error.localizedDescription.description, buttonText: "Ok")
      print(error.localizedDescription.description)
    }
  }
  
  private func applySnapshot(data: [City]) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, City>()
    snapshot.appendSections([1])
    snapshot.appendItems(data, toSection: 1)
    childView.diffableDataSource.apply(snapshot)
  }
  
}

extension SearchCityViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    switch viewModel.state {
    case .data(value: let cities):
      guard let cities = cities as? [City] else { return }
      let selectedCity = cities[indexPath.row]
      viewModel.saveCity(selectedCity)
    default:
      break
    }
    
  }
}

extension SearchCityViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let text = searchController.searchBar.text, !text.isEmpty else { return }
    viewModel.getCitiesContaining(text)
  }
}
