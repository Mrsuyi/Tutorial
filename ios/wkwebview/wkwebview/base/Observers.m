//
//  Observers.m
//  wkwebview
//
//  Created by Yi Su on 4/11/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "Observers.h"

@implementation Observers {
  NSPointerArray* _observers;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    _observers = [NSPointerArray weakObjectsPointerArray];
  }
  return self;
}

#pragma mark - Public methods

- (void)addObserver:(id)observer {
  [_observers addPointer:(__bridge void* _Nullable)observer];
}

- (void)removeObserver:(id)observer {
  for (NSUInteger i = 0; i < _observers.count; ++i) {
    if ((id)[_observers pointerAtIndex:i] == observer) {
      [_observers removePointerAtIndex:i];
      --i;
    }
  }
}

- (void)notify:(SEL)sel {
  [_observers compact];
  for (NSUInteger i = 0; i < _observers.count; ++i) {
    id observer = (id)[_observers pointerAtIndex:i];
    if ([observer respondsToSelector:sel]) {
      [observer performSelector:sel];
    }
  }
}

- (void)notify:(SEL)sel withObject:(id)object {
  [_observers compact];
  for (NSUInteger i = 0; i < _observers.count; ++i) {
    id observer = (id)[_observers pointerAtIndex:i];
    if ([observer respondsToSelector:sel]) {
      [observer performSelector:sel withObject:object];
    }
  }
}

- (void)notify:(SEL)sel withObject:(id)object1 withObject:(id)object2 {
  [_observers compact];
  for (NSUInteger i = 0; i < _observers.count; ++i) {
    id observer = (id)[_observers pointerAtIndex:i];
    if ([observer respondsToSelector:sel]) {
      [observer performSelector:sel withObject:object1 withObject:object2];
    }
  }
}

@end
