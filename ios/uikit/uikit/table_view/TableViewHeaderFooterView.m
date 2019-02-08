//
//  TableViewHeaderFooterView.m
//  uikit
//
//  Created by Yi Su on 1/21/19.
//  Copyright © 2019 google. All rights reserved.
//


#import "TableViewHeaderFooterView.h"

NSString* const kTableViewHeaderFooterViewReuseIdentifier = @"TableViewHeaderFooterViewReuseIdentifier";

@implementation TableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithReuseIdentifier:reuseIdentifier];
  if (self) {
//    self.textLabel.text = @"";
//    self.detailTextLabel.text = @"detail text";

//    self.textLabel.preferredMaxLayoutWidth = self.window.frame.size.width;
//    self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
//
//    UILabel* label = [[UILabel alloc] init];
//    label.translatesAutoresizingMaskIntoConstraints = NO;
//    label.text = @"afghrugiheirughaiubiaubdgiuabweiuhasiudfhiauwrbgadiyfbaiusv";
//    [self.contentView addSubview:label];
//    [NSLayoutConstraint activateConstraints:@[
//                                              [label.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
//                                              [label.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
//                                              [label.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
//                                              [label.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor]]];

    UITextView* view = [UITextView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    view.scrollEnabled = NO;
    view.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    view.adjustsFontForContentSizeCategory = YES;
    view.editable = NO;

    NSString* strippedText = @"the URL of the web site is asdfasdgferwgaweasdfasdf www.google.com";
    NSRange range = NSMakeRange(strippedText.length - 14, 14);
    NSRange fullRange = NSMakeRange(0, strippedText.length);
    NSMutableAttributedString* attributedText =
    [[NSMutableAttributedString alloc] initWithString:strippedText];
    [attributedText addAttribute:NSForegroundColorAttributeName
                           value:UIColor.redColor
                           range:fullRange];

    [attributedText
     addAttribute:NSFontAttributeName
     value:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]
     range:fullRange];

    if (range.location != NSNotFound && range.length != 0) {
      NSURL* URL = [NSURL URLWithString:@"www.google.com"];
      id linkValue = URL ? URL : @"";
      [attributedText addAttribute:NSLinkAttributeName
                             value:linkValue
                             range:range];
    }

    view.attributedText = attributedText;

    [self.contentView addSubview:view];
    [NSLayoutConstraint activateConstraints:@[
                                              [view.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
                                              [view.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
                                              [view.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
                                              [view.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor]]];
  }
  return self;
}

- (void)prepareForReuse {
  [super prepareForReuse];
  NSLog(@"prepareForReuse TableViewHeaderFooterView");
}

@end
