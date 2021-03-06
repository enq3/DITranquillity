//
//  DITranquillityTests_Threads.swift
//  DITranquillityTest
//
//  Created by Alexander Ivlev on 18/07/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import XCTest
import DITranquillity

class DITranquillityTests_Threads: XCTestCase {
  override func setUp() {
    super.setUp()
  }
  
  func test01_ResolvePerDependency() {
    let builder = DIContainerBuilder()
    
    builder.register(type: FooService.self)
      .lifetime(.perDependency)
      .initial(FooService.init)
    
    let container = try! builder.build()
    
    DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
      for _ in 0..<32768 {
        let service: FooService = try! *container
        XCTAssertEqual(service.foo(), "foo")
      }
    }
    
    DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async {
      for _ in 0..<16384 {
        let service: FooService = try! *container
        XCTAssertEqual(service.foo(), "foo")
      }
    }
    
    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
      for _ in 0..<8192 {
        let service: FooService = try! *container
        XCTAssertEqual(service.foo(), "foo")
      }
    }
  }
  
  func test02_ResolvePerSingle() {
    let builder = DIContainerBuilder()
    
    builder.register(type: FooService.self)
      .lifetime(.lazySingle)
      .initial{ FooService() }
    
    let container = try! builder.build()
    
    let singleService: FooService = try! *container
    XCTAssertEqual(singleService.foo(), "foo")
    
    DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
      for _ in 0..<32768 {
        let service: FooService = try! *container
        XCTAssert(service === singleService)
      }
    }
    
    DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async {
      for _ in 0..<16384 {
        let service: FooService = try! *container
        XCTAssert(service === singleService)
      }
    }
    
    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
      for _ in 0..<8192 {
        let service: FooService = try! *container
        XCTAssert(service === singleService)
      }
    }
  }
  
  func test03_ResolvePerScope() {
    let builder = DIContainerBuilder()
    
    builder.register(type: FooService.self)
      .lifetime(.perScope)
      .initial{ FooService() }
    
    let container = try! builder.build()
    
    let scopeService: FooService = try! *container
    XCTAssertEqual(scopeService.foo(), "foo")
    
    let scope = container.newLifeTimeScope()
    
    let scopeService2: FooService = try! *scope
    XCTAssertEqual(scopeService2.foo(), "foo")
    
    DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).async {
      for _ in 0..<32768 {
        let service: FooService = try! *container
        XCTAssert(service === scopeService)
        let service2: FooService = try! *scope
        XCTAssert(service2 === scopeService2)
      }
    }
    
    DispatchQueue.global(qos: DispatchQoS.QoSClass.utility).async {
      for _ in 0..<16384 {
        let service: FooService = try! *container
        XCTAssert(service === scopeService)
        let service2: FooService = try! *scope
        XCTAssert(service2 === scopeService2)
      }
    }
    
    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
      for _ in 0..<8192 {
        let service: FooService = try! *container
        XCTAssert(service === scopeService)
        let service2: FooService = try! *scope
        XCTAssert(service2 === scopeService2)
      }
    }
  }
}
