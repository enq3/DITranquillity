//
//  DIStoryboardBase.m
//  DITranquillity
//
//  Created by Alexander Ivlev on 03/10/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

#import "DIStoryboardBase.h"

@implementation _DIStoryboardBase

+ (nonnull instancetype)create:(nonnull NSString*)name bundle:(nullable NSBundle*)storyboardBundleOrNil {
  _DIStoryboardBase* storyboard = (_DIStoryboardBase*)[self storyboardWithName:name bundle:storyboardBundleOrNil];
  return storyboard;
}

- (nonnull __kindof NSViewController*)instantiateControllerWithIdentifier:(nonnull NSString*)identifier {
  id viewController = [super instantiateControllerWithIdentifier: identifier];
  
  __typeof(self.resolver) __strong sResolver = self.resolver;
  if (nil == sResolver) {
    return viewController;
  }
  
  return [sResolver resolve:viewController identifier:identifier];
}

@end
