//
//  TweetsOnMapViewController.m
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import "TweetsOnMapViewController.h"
#import "GetCurrentLocation.h"
#import "MyLocation.h"
#import "TweetsAroundMe.h"
#import "GetCurrentLocation.h"
#import "WOEIDUtil.h"
#import "TweetsAroundMeViewController.h"
#import "TweetsAroundMeSingleton.h"


@interface TweetsOnMapViewController ()
@property (strong, nonatomic) NSArray *tweets;
@end

@implementation TweetsOnMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


// Fetch tweets from tweetsAroundMe and populate tweets
- (void) fetchTweets
{
    TweetsAroundMeSingleton *sharedInstance = [TweetsAroundMeSingleton sharedInstance];
    //self.tweets = [sharedInstance fetchTrendingTweets];
    self.tweets = [sharedInstance fetchTweets];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [__mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        
        annotationView.image=[UIImage imageNamed:@"twitter-logo-small.gif"];        
        return annotationView;
    }
    
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 37.781157;
    zoomLocation.longitude= -122.398720;
    // 2
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 2 * METERS_PER_MILE, 2 * METERS_PER_MILE);
    // 3
    //MKCoordinateRegion adjustedRegion = [__mapView regionThatFits:viewRegion];
    // 4
    [__mapView setRegion:viewRegion animated:YES];
}

- (void)plotTweetsOnMap {
    
    [self fetchTweets]; // Fetch Tweets into self.tweets
    
    for (id<MKAnnotation> annotation in __mapView.annotations) {
        [__mapView removeAnnotation:annotation];
    }
    
    for (NSDictionary *tweet in self.tweets) {
        NSLog(@"Tweet received is %@", tweet);
        NSString *tweetText = tweet[@"text"];
        NSString *userName = tweet[@"user"][@"screen_name"];
        NSString *geoString = tweet[@"geo"];
        if (nil == geoString || [NSNull null] == (id)geoString) {
            NSLog(@"Ah! sucker!");
            continue;
        }
        NSDictionary *geo = tweet[@"geo"];
        if (geo != nil) {
            NSArray *coordinates = geo[@"coordinates"];
            NSLog(@"Geo values : %@", coordinates);
        
            NSNumber * latitude = coordinates[0];
            NSNumber * longitude = coordinates[1];
        
        
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = latitude.doubleValue;
            coordinate.longitude = longitude.doubleValue;
            MyLocation *annotation = [[MyLocation alloc] initWithName:tweetText user:userName coordinate:coordinate];
        
            [__mapView addAnnotation:annotation];
        }
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshTapped:(id)sender {
    [self plotTweetsOnMap];
}
@end
