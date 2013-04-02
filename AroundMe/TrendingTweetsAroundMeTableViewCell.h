//
//  TrendingTweetsAroundMeTableViewCell.h
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrendingTweetsAroundMeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextView *trendingTweetText;
@property (strong, nonatomic) IBOutlet UIImageView *trendingTweetProfilePic;

@end
