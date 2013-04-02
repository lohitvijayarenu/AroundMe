//
//  GetCurrentLocation.m
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import "GetCurrentLocation.h"

@implementation GetCurrentLocation
+(NSString *)getCurrentLocation
{
  return @"37.781157,-122.398720,2mi";
}

+(NSString *)getCurrentLocationWithoutRadius
{
    return @"37.781157,-122.398720";
}

+(NSString *)getCurrentLocationWithLargetRadius
{
    return @"37.781157,-122.398720,15mi";
}

+(NSString *) getCurrentLat
{
    return @"37.781157";
}

+(NSString *) getCurrentLog
{
    return @"-122.398720";
}


@end
