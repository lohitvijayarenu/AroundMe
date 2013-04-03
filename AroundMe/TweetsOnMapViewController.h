//
//  TweetsOnMapViewController.h
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#define METERS_PER_MILE 1609.344


@interface TweetsOnMapViewController : UIViewController <MKMapViewDelegate>
- (IBAction)refreshTapped:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *_mapView;

@end
