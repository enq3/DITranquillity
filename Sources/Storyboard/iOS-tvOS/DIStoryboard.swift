//
//  DIStoryboard.swift
//  DITranquillity
//
//  Created by Alexander Ivlev on 05/07/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import UIKit

public final class DIStoryboard: UIStoryboard {
  public required init(name: String, bundle storyboardBundleOrNil: Bundle?, container: DIContainer) {
    storyboard = _DIStoryboardBase.create(name, bundle: storyboardBundleOrNil)
    super.init()
    storyboard.resolver = DIStoryboardResolver(container: container)
  }

  public override func instantiateInitialViewController() -> UIViewController? {
    return storyboard.instantiateInitialViewController()
  }

  public override func instantiateViewController(withIdentifier identifier: String) -> UIViewController {
    return storyboard.instantiateViewController(withIdentifier: identifier)
  }

  private let storyboard: _DIStoryboardBase
}

public extension DIContainerBuilder {
  @discardableResult
  public func register<T: UIViewController>(vc type: T.Type, file: String = #file, line: Int = #line) -> DIRegistrationBuilder<T> {
    return registrationBuilder(file: file, line: line)
      .as(.self)
      .initialNotNecessary()
  }
}

// ViewController
public extension DIRegistrationBuilder where Impl: UIViewController {
  @discardableResult
  public func initial<T: UIViewController>(nib type: T.Type) -> Self {
    rType.append(initial: { (_:DIContainer) throws -> Any in UIViewController(nibName: String(describing: type), bundle: Bundle(for: type)) as! T })
    return self
  }
  
  @discardableResult
  public func initial(useStoryboard storyboard: UIStoryboard, identifier: String) -> Self {
    rType.append(initial: { (_:DIContainer) throws -> Any in storyboard.instantiateViewController(withIdentifier: identifier) })
    return self
  }
  
  @discardableResult
  public func initial(useStoryboard closure: @escaping (DIContainer) throws -> UIStoryboard, identifier: String) -> Self {
    rType.append(initial: { c -> Any in try closure(c).instantiateViewController(withIdentifier: identifier) })
    return self
  }
}

// Storyboard
public extension DIRegistrationBuilder where Impl: UIStoryboard {
  @discardableResult
  public func initial(name: String, bundle storyboardBundleOrNil: Bundle?) -> Self {
    self.initial { c throws -> Impl in DIStoryboard(name: name, bundle: storyboardBundleOrNil, container: c) as! Impl }
    return self
  }
}

