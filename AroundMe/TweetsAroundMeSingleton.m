//
//  TweetsAroundMeSingleton.m
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/3/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import "TweetsAroundMeSingleton.h"
#import "TweetsAroundMe.h"
#import "GetCurrentLocation.h"
#import "WOEIDUtil.h"

@interface TweetsAroundMeSingleton()
@property (strong, nonatomic) TweetsAroundMe *tweetsAroundMe;

@end

@implementation TweetsAroundMeSingleton

- (TweetsAroundMe *) tweetsAroundMe
{
    if (!_tweetsAroundMe) _tweetsAroundMe = [[TweetsAroundMe alloc] init];
    return _tweetsAroundMe;
}


static TweetsAroundMeSingleton *sharedInstance = nil;


// Get the shared instance and create it if necessary.
+ (TweetsAroundMeSingleton *)sharedInstance {
    if (nil != sharedInstance) {
        return sharedInstance;
    }
    
    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app
        sharedInstance = [[TweetsAroundMeSingleton alloc] init];
    });
    
    return sharedInstance;
}

- (NSArray *) fetchTweets
{
    NSString *location = [GetCurrentLocation getCurrentLocation];
    NSArray *results = [self.tweetsAroundMe fetchTweets:location];
    return results;
}

- (NSArray *) fetchTrendingTweets
{
    NSString *location = [GetCurrentLocation getCurrentLocation];
    NSString *woeid = [WOEIDUtil getCurrentWOEID];
    NSArray *results = [self.tweetsAroundMe fetchTrendingTweets:location :woeid];
    return results;
}

// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
    }
    
    return self;
}

// Your dealloc method will never be called, as the singleton survives for the duration of your app.
// However, I like to include it so I know what memory I'm using (and incase, one day, I convert away from Singleton).
//-(void)dealloc
//{
//    // I'm never called!
//    [super dealloc];
//}

// We don't want to allocate a new instance, so return the current one.
//+ (id)allocWithZone:(NSZone*)zone {
//    NSLog(@"THIS SHOULD HAVE NOT BEEN CALLED");
//    return [[self sharedInstance] ];
//}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

// Once again - do nothing, as we don't have a retain counter for this object.
//- (id)retain {
//    return self;
//}

// Replace the retain counter so we can never release this object.
//- (NSUInteger)retainCount {
//    return NSUIntegerMax;
//}

// This function is empty, as we don't want to let the user release this object.
//- (oneway void)release {
//
//}

//Do nothing, other than return the shared instance - as this is expected from autorelease.
//- (id)autorelease {
//    return self;
//}

@end
