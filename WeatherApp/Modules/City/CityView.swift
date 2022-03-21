//
//  CityView.swift
//  WeatherApp
//
//  Created by Bruno Frani on 5.3.22.
//

import UIKit

class CityView: UIView {
  
  lazy var collectionView: UICollectionView = {
    let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    let layout = UICollectionViewCompositionalLayout.list(using: config)
    
    let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return collectionView
  }()
  
  
  lazy var diffableDataSource: UICollectionViewDiffableDataSource<Int, ConsolidatedWeather> = {
    // Configures the collection view cell
    let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ConsolidatedWeather> { cell, indexPath, forecast in
      var content = cell.defaultContentConfiguration()
      content.text = forecast.applicableDate
      cell.contentConfiguration = content
    }
    let dataSource = UICollectionViewDiffableDataSource<Int, ConsolidatedWeather>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
      let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
      return cell
    }
    return dataSource
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViewsAndConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViewsAndConstraints() {
    addSubview(collectionView)
  }
}
