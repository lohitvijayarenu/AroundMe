//
//  GetCurrentLocation.h
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCurrentLocation : NSObject
+(NSString *) getCurrentLocation;
+(NSString *) getCurrentLat;
+(NSString *) getCurrentLog;
+(NSString *)getCurrentLocationWithoutRadius;
+(NSString *)getCurrentLocationWithLargetRadius;
@end
