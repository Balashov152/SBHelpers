//
//  DataSource.swift
//  SellFashion
//
//  Created by Sergey Balashov on 29.10.2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import RxDataSources

public typealias TableViewSection = AnimatableSectionModel<String, TableSectionItem>
public typealias CollectionViewSection = AnimatableSectionModel<String, CollectionSectionItem>

public struct StringDataSource {
    public struct TableView {
        public static func animated(animationConfiguration: AnimationConfiguration? = nil) -> RxTableViewSectionedAnimatedDataSource<TableViewSection> {
            return DataSource<String>.TableView.animated(animationConfiguration: animationConfiguration)
        }

        public static func reload() -> RxTableViewSectionedReloadDataSource<TableViewSection> {
            return DataSource<String>.TableView.reload()
        }
    }

    public struct CollectionView {
        public static func animated(animationConfiguration: AnimationConfiguration? = nil) -> RxCollectionViewSectionedAnimatedDataSource<CollectionViewSection> {
            DataSource<String>.CollectionView.animated(animationConfiguration: animationConfiguration)
        }

        public static func reload() -> RxCollectionViewSectionedReloadDataSource<CollectionViewSection> {
            return DataSource<String>.CollectionView.reload()
        }
    }
}

public struct DataSource<Section> where Section: IdentifiableType {
    public struct TableView {
        public typealias TableViewSection = AnimatableSectionModel<Section, TableSectionItem> // swiftlint:disable:this nesting
        static func animated(animationConfiguration: AnimationConfiguration? = nil) -> RxTableViewSectionedAnimatedDataSource<TableViewSection> {
            let animationConfiguration = animationConfiguration ?? AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade)
            return .init(animationConfiguration: animationConfiguration, configureCell: ConfigureViewModable<TableViewSection>().configureCell)
        }

        public static func reload() -> RxTableViewSectionedReloadDataSource<TableViewSection> {
            return .init(configureCell: ConfigureViewModable<TableViewSection>().configureCell)
        }
    }

    public struct CollectionView {
        public typealias CollectionViewSection = AnimatableSectionModel<Section, CollectionSectionItem> // swiftlint:disable:this nesting
        public static func animated(animationConfiguration: AnimationConfiguration? = nil) -> RxCollectionViewSectionedAnimatedDataSource<CollectionViewSection> {
            let animationConfiguration = animationConfiguration ?? AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade)
            return .init(animationConfiguration: animationConfiguration, configureCell: ConfigureViewModable<CollectionViewSection>().collectionConfigureCell)
        }

        public static func reload() -> RxCollectionViewSectionedReloadDataSource<CollectionViewSection> {
            return .init(configureCell: ConfigureViewModable<CollectionViewSection>().collectionConfigureCell)
        }
    }
}
