//
//  DataSource.swift
//  SellFashion
//
//  Created by Sergey Balashov on 29.10.2019.
//  Copyright © 2019 Egor Otmakhov. All rights reserved.
//

import RxDataSources

typealias TableViewSection = AnimatableSectionModel<String, TableSectionItem>
typealias CollectionViewSection = AnimatableSectionModel<String, CollectionSectionItem>

struct StringDataSource {
    struct TableView {
        static func animated(animationConfiguration: AnimationConfiguration? = nil) -> RxTableViewSectionedAnimatedDataSource<TableViewSection> {
            return DataSource<String>.TableView.animated(animationConfiguration: animationConfiguration)
        }

        static func reload() -> RxTableViewSectionedReloadDataSource<TableViewSection> {
            return DataSource<String>.TableView.reload()
        }
    }

    struct CollectionView {
        static func animated(animationConfiguration: AnimationConfiguration? = nil) -> RxCollectionViewSectionedAnimatedDataSource<CollectionViewSection> {
            DataSource<String>.CollectionView.animated(animationConfiguration: animationConfiguration)
        }

        static func reload() -> RxCollectionViewSectionedReloadDataSource<CollectionViewSection> {
            return DataSource<String>.CollectionView.reload()
        }
    }
}

struct DataSource<Section> where Section: IdentifiableType {
    struct TableView {
        typealias TableViewSection = AnimatableSectionModel<Section, TableSectionItem> // swiftlint:disable:this nesting
        static func animated(animationConfiguration: AnimationConfiguration? = nil) -> RxTableViewSectionedAnimatedDataSource<TableViewSection> {
            let animationConfiguration = animationConfiguration ?? AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade)
            return .init(animationConfiguration: animationConfiguration, configureCell: ConfigureViewModable<TableViewSection>().configureCell)
        }

        static func reload() -> RxTableViewSectionedReloadDataSource<TableViewSection> {
            return .init(configureCell: ConfigureViewModable<TableViewSection>().configureCell)
        }
    }

    struct CollectionView {
        typealias CollectionViewSection = AnimatableSectionModel<Section, CollectionSectionItem> // swiftlint:disable:this nesting
        static func animated(animationConfiguration: AnimationConfiguration? = nil) -> RxCollectionViewSectionedAnimatedDataSource<CollectionViewSection> {
            let animationConfiguration = animationConfiguration ?? AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade)
            return .init(animationConfiguration: animationConfiguration, configureCell: ConfigureViewModable<CollectionViewSection>().collectionConfigureCell)
        }

        static func reload() -> RxCollectionViewSectionedReloadDataSource<CollectionViewSection> {
            return .init(configureCell: ConfigureViewModable<CollectionViewSection>().collectionConfigureCell)
        }
    }
}
