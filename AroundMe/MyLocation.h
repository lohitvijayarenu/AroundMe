//
//  MyLocation.h
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : NSObject <MKAnnotation> {
    NSString *_tweet;
    NSString *_user;
    NSString *_pic;
    CLLocationCoordinate2D _coordinate;
}

@property (copy) NSString *tweet;
@property (copy) NSString *user;
@property (copy) NSString *pic;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)tweet user:(NSString *)user coordinate:(CLLocationCoordinate2D)coordinate;

@end