//
//  SearchCityView.swift
//  WeatherApp
//
//  Created by Bruno Frani on 14.3.22.
//

import UIKit

class SearchCityView: UIView {
  
  lazy var collectionView: UICollectionView = {
    let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    let layout = UICollectionViewCompositionalLayout.list(using: config)
    
    let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return collectionView
  }()
  
  lazy var noDataLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "No data found"
    label.textAlignment = .center
    return label
  }()
  
  lazy var diffableDataSource: UICollectionViewDiffableDataSource<Int, City> = {
    // Configures the collection view cell
    let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, City> { cell, indexPath, city in
      var content = cell.defaultContentConfiguration()
      content.text = city.title
      cell.contentConfiguration = content
    }
    let dataSource = UICollectionViewDiffableDataSource<Int, City>(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
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
    addSubview(noDataLabel)
    noDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    noDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    noDataLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    noDataLabel.isHidden = true
  }
}
