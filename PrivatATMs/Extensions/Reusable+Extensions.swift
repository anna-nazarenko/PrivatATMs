//
//  Reusable+Extensions.swift
//  PrivatATMs
//
//  Created by Anna Nazarenko on 18.03.2022.
//

import UIKit

/**
 Type which can be reused by identifier.
 */
public protocol Reusable: AnyObject {
    
    static var reuseIdentifier: String { get }
}

/**
 Default reuse identifier is conforming class name.
 */
public extension Reusable {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable { }
extension UICollectionReusableView: Reusable { }
extension UITableViewHeaderFooterView: Reusable { }

public extension UITableView {
    
    /**
     
     Regiser UITableViewHeaderFooterView from .xib or class.
     
     ### Usage Example: ###
     `
     tableView.registerHeaderFooter(TitleButtonHeaderView.self)
     `
     
     - Parameter headerFooterType: TableViewHeaderFooterView which should be registered.
     */
    func registerHeaderFooter(_ headerFooterType: Reusable.Type...) {
        for headerFooterType in headerFooterType {
            if let nib = headerFooterType.nib {
                self.register(nib, forHeaderFooterViewReuseIdentifier: headerFooterType.reuseIdentifier)
            } else {
                self.register(headerFooterType, forHeaderFooterViewReuseIdentifier: headerFooterType.reuseIdentifier)
            }
        }
    }
    
    /**
     
     Returns reused UITableViewHeaderFooterView casted to reusable type.
     Used together with Configurable and Delegating protocols.
     
     ### Usage Example: ###
     `
     tableView
         .dequeueReusableHeaderFooterView(withType: TitleButtonHeaderView.self)
         .configured(with: TitleButtonHeaderView.Configurator, delegating: self)
     `
     
     - Parameter type: View type which should be reused.
     - Returns: Casted to reusable type view.
     */
    func dequeueReusableHeaderFooterView<T>(withType type: T.Type) -> T where T: Reusable {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
    
    /**
     
     Regiser UITableViewCell from .xib or class.
     
     ### Usage Example: ###
     `
     tableView.register(CardTableViewCell.self, AccountTableViewCell.self)
     `
     
     - Parameter cellType: Cell which should be registered.
     */
    func register(_ cellType: Reusable.Type...) {
        for cellType in cellType {
            if let nib = cellType.nib {
                self.register(nib, forCellReuseIdentifier: cellType.reuseIdentifier)
            } else {
                self.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
            }
        }
    }
    
    /**
     
     Returns reused UITableViewCell casted to reusable type.
     Used together with Configurable and Delegating protocols.
     
     ### Usage Example: ###
     `
     tableView
         .dequeueReusableCell(withType: CardTableViewCell.self, for: indexPath)
         .configured(with: card, delegating: self)
     `
     
     - Parameter type: Cell type which should be reused.
     - Parameter indexPath: Reusing index path.
     - Returns: Casted to reusable type cell.
     */
    func dequeueReusableCell<T>(withType type: T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

public extension UICollectionView {
    
    /**
     
     Regiser UICollectionViewCell from .xib or class.
     
     ### Usage Example: ###
     `
     collectionView.register(CardCollectionViewCell.self)
     `
     
     - Parameter cellType: Cell which should be registered.
     */
    func register(_ cellType: Reusable.Type...) {
        for cellType in cellType {
            if let nib = cellType.nib {
                self.register(nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
            } else {
                self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
            }
        }
    }
    
    /**
     
     Returns reused UICollectionViewCell casted to reusable type.
     Used together with Configurable and Delegating protocols.
     
     ### Usage Example: ###
     `
     collectionView
         .dequeueReusableCell(withType: CardCollectionViewCell.self, for: indexPath)
         .configured(with: card, delegating: self)
     `
     
     - Parameter type: Cell type which should be reused.
     - Parameter indexPath: Reusing index path.
     - Returns: Casted to reusable type cell.
     */
    func dequeueReusableCell<T>(withType type: T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

extension Reusable {
    
    static var nib: UINib? {
        
        let bundle = Bundle(for: Self.self)
        
        guard bundle.path(forResource: self.reuseIdentifier, ofType: "nib") != nil else {
            return nil
        }
        
        return UINib(nibName: self.reuseIdentifier, bundle: bundle)
    }
}
