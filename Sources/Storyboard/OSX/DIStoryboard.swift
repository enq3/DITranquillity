//
//  DIStoryboard.swift
//  DITranquillity
//
//  Created by Alexander Ivlev on 03/10/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import Cocoa

public final class DIStoryboard: NSStoryboard {
  public required init(name: String, bundle storyboardBundleOrNil: Bundle?, container: DIContainer) {
    storyboard = _DIStoryboardBase.create(name, bundle: storyboardBundleOrNil)
    super.init()
    storyboard.resolver = DIStoryboardResolver(container: container)
  }

  public override func instantiateInitialController() -> Any? {
    return storyboard.instantiateInitialController()
  }

  public override func instantiateController(withIdentifier identifier: String) -> Any {
    return storyboard.instantiateController(withIdentifier: identifier)
  }
  
  private let storyboard: _DIStoryboardBase
}

public extension DIContainerBuilder {
  @discardableResult
  public func register<T: AnyObject>(vc type: T.Type, file: String = #file, line: Int = #line) -> DIRegistrationBuilder<T> {
    return registrationBuilder(file: file, line: line)
      .as(.self)
      .initialNotNecessary()
  }
}

// ViewController
public extension DIRegistrationBuilder where Impl: NSViewController {
  @discardableResult
  public func initial<T: NSViewController>(nib type: T.Type) -> Self {
    rType.append(initial: { (_:DIContainer) throws -> Any in NSViewController(nibName: String(describing: type), bundle: Bundle(for: type)) as! T })
    return self
  }
  
  @discardableResult
  public func initial(useStoryboard storyboard: NSStoryboard, identifier: String) -> Self {
    rType.append(initial: { (_:DIContainer) throws -> Any in storyboard.instantiateController(withIdentifier: identifier) })
    return self
  }
  
  @discardableResult
  public func initial(useStoryboard closure: @escaping (_: DIContainer) throws -> NSStoryboard, identifier: String) -> Self {
    rType.append(initial: { c -> Any in try closure(c).instantiateController(withIdentifier: identifier) })
    return self
  }
}

// Storyboard
public extension DIRegistrationBuilder where Impl: NSStoryboard {
  @discardableResult
  public func initial(name: String, bundle storyboardBundleOrNil: Bundle?) -> Self {
    self.initial { c throws -> Impl in DIStoryboard(name: name, bundle: storyboardBundleOrNil, container: c) as! Impl }
    return self
  }
}

