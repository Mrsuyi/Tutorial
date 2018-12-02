//
//  ResultController.m
//  SearchBar
//
//  Created by Yi Su on 02/12/2018.
//  Copyright © 2018 google. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ResultController.h"

@implementation ResultController

# pragma UIViewController

@synthesize label = _label;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = UIColor.whiteColor;

  _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
  _label.text = @"shit";
  _label.textColor = UIColor.blackColor;

  [self.view addSubview:_label];
}

# pragma UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
  NSLog(@"updateSearchResultsForSearchController");
  _label.text = searchController.searchBar.text;
}

@end
