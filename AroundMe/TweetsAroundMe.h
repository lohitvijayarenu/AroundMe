//
//  TweetsAroundMe.h
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetsAroundMe : NSObject
- (NSArray *) fetchTweets:(NSString *)aroundLocation; // Return tweets
- (NSArray *) fetchTrendingTweets:(NSString *)aroundWOEID;
@property (nonatomic, strong) NSArray * tweets;
@end
