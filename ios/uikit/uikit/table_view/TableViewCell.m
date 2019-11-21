//
//  TableViewCell.m
//  uikit
//
//  Created by Yi Su on 1/21/19.
//  Copyright © 2019 google. All rights reserved.
//

#import "TableViewCell.h"

NSString* const kTableViewCellReuseIdentifier = @"TableViewCellReuseIdentifier";

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.textLabel.text = @"text";
    self.detailTextLabel.text = @"detail text";
    self.imageView.image = [UIImage imageNamed:@"chrome_32_32.png"];
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
  }
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
  NSLog(@"prepareForReuse TableViewCell");
}

@end
