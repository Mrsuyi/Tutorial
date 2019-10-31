//
//  Observers.m
//  wkwebview
//
//  Created by Yi Su on 4/11/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "ObserverList.h"

@implementation ObserverList

- (instancetype)init {
  self = [super init];
  if (self) {
    _observers = [NSPointerArray weakObjectsPointerArray];
  }
  return self;
}

#pragma mark - Public methods

- (void)addObserver:(id)observer {
  [self.observers addPointer:(__bridge void* _Nullable)observer];
}

- (void)removeObserver:(id)observer {
  for (NSUInteger i = 0; i < self.observers.count; ++i) {
    if ((id)[self.observers pointerAtIndex:i] == observer) {
      [self.observers removePointerAtIndex:i];
      --i;
    }
  }
}

- (void)notify:(SEL)sel {
  [self.observers compact];
  for (NSUInteger i = 0; i < self.observers.count; ++i) {
    id observer = (id)[self.observers pointerAtIndex:i];
    if ([observer respondsToSelector:sel]) {
      IMP imp = [observer methodForSelector:sel];
      void (*func)(id, SEL) = (void*)imp;
      func(observer, sel);
    }
  }
}

- (void)notify:(SEL)sel withObject:(id)object {
  [self.observers compact];
  for (NSUInteger i = 0; i < self.observers.count; ++i) {
    id observer = (id)[self.observers pointerAtIndex:i];
    if ([observer respondsToSelector:sel]) {
      IMP imp = [observer methodForSelector:sel];
      void (*func)(id, SEL, id) = (void*)imp;
      func(observer, sel, object);
    }
  }
}

- (void)notify:(SEL)sel withObject:(id)object1 withObject:(id)object2 {
  [self.observers compact];
  for (NSUInteger i = 0; i < self.observers.count; ++i) {
    id observer = (id)[self.observers pointerAtIndex:i];
    if ([observer respondsToSelector:sel]) {
      IMP imp = [observer methodForSelector:sel];
      void (*func)(id, SEL, id, id) = (void*)imp;
      func(observer, sel, object1, object2);
    }
  }
}

- (void)notify:(SEL)sel
      withObject:(id)object1
      withObject:(id)object2
    withUInteger:(NSUInteger)uinteger {
  [self.observers compact];
  for (NSUInteger i = 0; i < self.observers.count; ++i) {
    id observer = (id)[self.observers pointerAtIndex:i];
    if ([observer respondsToSelector:sel]) {
      IMP imp = [observer methodForSelector:sel];
      void (*func)(id, SEL, id, id, NSUInteger) = (void*)imp;
      func(observer, sel, object1, object2, uinteger);
    }
  }
}

- (void)notify:(SEL)sel
      withObject:(id)object1
      withObject:(id)object2
    withUInteger:(NSUInteger)uinteger1
      withObject:(id)object3
    withUInteger:(NSUInteger)uinteger2 {
  [self.observers compact];
  for (NSUInteger i = 0; i < self.observers.count; ++i) {
    id observer = (id)[self.observers pointerAtIndex:i];
    if ([observer respondsToSelector:sel]) {
      IMP imp = [observer methodForSelector:sel];
      void (*func)(id, SEL, id, id, NSUInteger, id, NSUInteger) = (void*)imp;
      func(observer, sel, object1, object2, uinteger1, object3, uinteger2);
    }
  }
}

@end
