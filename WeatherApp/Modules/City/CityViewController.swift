//
//  CityViewController.swift
//  WeatherApp
//
//  Created by Bruno Frani on 5.3.22.
//

import UIKit
import Combine

class CityViewController: UIViewController {
  
  private let viewModel: CityViewModel
  private let dependecies: AppDependencies
  private var childView: CityView!
  private var subscriptions = Set<AnyCancellable>()
  
  init(dependecies: AppDependencies, woeid: Int) {
    let viewModel = CityViewModel(dependencies: dependecies, woeid: woeid)
    self.viewModel = viewModel
    self.dependecies = dependecies
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    let homeView = CityView()
    childView = homeView
    view = childView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Forecast Days"
    childView.collectionView.delegate = self
    bindViewModel()
    viewModel.getForecast()
    viewModel.downloadImages()
    
  }
  
  private func bindViewModel() {
    viewModel.$state.sink { [weak self] state in
      self?.updateViewForState(state)
    }.store(in: &subscriptions)
  }
  
  private func updateViewForState(_ state: ViewModelState) {
    switch state {
    case .initial, .empty:
      break
    case .loading:
      displayAnimatedActivityIndicatorView()
    case .data(let weather):
      guard let weather = weather as? [ConsolidatedWeather] else { return }
      applySnapshot(data: weather)
      hideAnimatedActivityIndicatorView()
    case .error(let error):
      hideAnimatedActivityIndicatorView()
      showAlert(alertText: "Error", alertMessage: error.localizedDescription.description, buttonText: "Ok")
    }
  }
  
  private func applySnapshot(data: [ConsolidatedWeather]) {
    var snapshot = NSDiffableDataSourceSnapshot<Int, ConsolidatedWeather>()
    snapshot.appendSections([1])
    snapshot.appendItems(data, toSection: 1)
    childView.diffableDataSource.apply(snapshot)
  }
  
}

extension CityViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    let selectedDay = viewModel.consolidatedWeather[indexPath.row]
    let dayViewController = DayViewController(weather: selectedDay)
    navigationController?.pushViewController(dayViewController, animated: true)
  }
  
}
