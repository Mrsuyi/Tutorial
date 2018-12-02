//
//  ResultController.h
//  SearchBar
//
//  Created by Yi Su on 02/12/2018.
//  Copyright © 2018 google. All rights reserved.
//

#ifndef ResultController_h
#define ResultController_h

#import <UIKit/UIKit.h>

@interface ResultController : UIViewController <UISearchResultsUpdating>

@property (strong) UILabel* label;

@end

#endif /* ResultController_h */
