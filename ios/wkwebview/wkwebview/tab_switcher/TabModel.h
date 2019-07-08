//
//  TabModel.h
//  wkwebview
//
//  Created by Yi Su on 4/9/19.
//  Copyright © 2019 google. All rights reserved.
//

#ifndef TabModel_h
#define TabModel_h

#import <UIKit/UIKit.h>

@interface TabModel : NSObject

+ (instancetype)modelWithID:(id)ID
                  incognito:(BOOL)incognito
                      title:(NSString*)title
                 screenShot:(UIImage*)screenShot;

@property(nonatomic, weak) id ID;
@property(nonatomic, assign) BOOL incognito;
@property(nonatomic, copy) NSString* title;
@property(nonatomic, strong) UIImage* screenShot;

@end

#endif /* TabModel_h */
