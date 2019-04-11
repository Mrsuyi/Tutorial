//
//  Header.h
//  wkwebview
//
//  Created by Yi Su on 4/11/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <Foundation/Foundation.h>

@interface Observers<__covariant ObserverProtocol> : NSObject

- (void)addObserver:(ObserverProtocol)observer;
- (void)removeObserver:(ObserverProtocol)observer;

- (void)notify:(SEL)sel;
- (void)notify:(SEL)sel withObject:(id)object;
- (void)notify:(SEL)sel withObject:(id)object1 withObject:(id)object2;

@end

#endif /* Header_h */
