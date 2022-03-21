//
//  HomeView.swift
//  WeatherApp
//
//  Created by Bruno Frani on 5.3.22.
//

import UIKit
import CoreData

class HomeView: UIView {
  
  lazy var collectionView: UICollectionView = {
    let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    let layout = UICollectionViewCompositionalLayout.list(using: config)
    
    let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return collectionView
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
  }
}
