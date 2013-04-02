//
//  WOEIDUtil.m
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import "WOEIDUtil.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "GetCurrentLocation.h"



@implementation WOEIDUtil
+(NSString *) getAppId
{
    return @"pY0KsS3V34EBn6Uir.jIig9DEZRQBELQnzwKKmSOoFUBnFFPeL.R3unhP.NPeHg-";
}

+(NSString *) getCurrentWOEID
{
    return @"12797158"; // This is WOEID for location 37.781157,-122.398720
}


+(NSString *) getCurrentWOEIDNotWorking
{
    NSURL *requestURL = [NSURL URLWithString:@"http://where.yahooapis.com/geocode"];
    NSLog(@"Making request for URL : %@", requestURL);
    
    NSMutableDictionary *parameters =
    [[NSMutableDictionary alloc] init];
    [parameters setObject:[GetCurrentLocation getCurrentLocationWithoutRadius] forKey:@"location"];
    [parameters setObject:@"J" forKey:@"flags"];
    [parameters setObject:@"R" forKey:@"gflags"];
    [parameters setObject:[WOEIDUtil getAppId] forKey:@"appid"];
    
    NSString *u = [NSString stringWithFormat:@"http://where.yahooapis.com/geocode?location=%@&flags=J&gflags=R&appid=%@", [GetCurrentLocation getCurrentLocationWithoutRadius], [WOEIDUtil getAppId]];
    NSLog(@"URL constructed : %@", u);
    
    //NSString *u2 = [NSString stringWithFormat:@"http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.placefinder%20where%20text%3D%2237.416275%2C-122.025092%22%20and%20gflags%3D%22R%22&diagnostics=true"];
    
    NSURL *url = [NSURL URLWithString:u];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"ret=%@", ret);
    
    return @"23812";
}
@end
