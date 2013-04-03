//
//  TweetsAroundMeSingleton.h
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/3/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TweetsAroundMeSingleton : NSObject
{
    
}

+ (id) sharedInstance;
- (NSArray *) fetchTweets;
- (NSArray *) fetchTrendingTweets;

@end
