//
//  MyLocation.m
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import "MyLocation.h"

@implementation MyLocation
@synthesize tweet = _tweet;
@synthesize user = _user;
@synthesize pic = _pic;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString*)tweet user:(NSString *)user coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _tweet = [tweet copy];
        _user = [user copy];
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    if ([_tweet isKindOfClass:[NSNull class]])
        return @"Unknown tweet";
    else
        return _tweet;
}

- (NSString *)subtitle {
    return _user;
}


- (NSString *) getPic {
    return _pic;
}
@end
