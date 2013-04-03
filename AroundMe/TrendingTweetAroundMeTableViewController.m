//
//  TrendingTweetAroundMeTableViewController.m
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import "TrendingTweetAroundMeTableViewController.h"
#import "TrendingTweetsAroundMeTableViewCell.h"
#import "TweetsAroundMe.h"
#import "GetCurrentLocation.h"
#import "WOEIDUtil.h"

@interface TrendingTweetAroundMeTableViewController ()
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) TweetsAroundMe *tweetsAroundMe;
@end

@implementation TrendingTweetAroundMeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (TweetsAroundMe *) tweetsAroundMe
{
    if (!_tweetsAroundMe) _tweetsAroundMe = [[TweetsAroundMe alloc]init];
    return _tweetsAroundMe;
}

- (NSArray *) tweets
{
    NSString *location = [GetCurrentLocation getCurrentLocationWithLargetRadius];
    if (!_tweets) _tweets = [self.tweetsAroundMe fetchTrendingTweets:location :[WOEIDUtil getCurrentWOEID]];
    return _tweets;
}

// Fetch tweets from tweetsAroundMe and populate tweets
- (void) fetchTweets
{
    NSString *location = [GetCurrentLocation getCurrentLocationWithLargetRadius];
    
    self.tweets = [self.tweetsAroundMe fetchTrendingTweets:location :[WOEIDUtil getCurrentWOEID]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 20; // HACK!!
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self fetchTweets];
    static NSString *CellIdentifier = @"trendingTweetsCell";
    if ([indexPath row] > self.tweets.count)
    {
        NSLog(@"PROBLEM!!!");
        //cell.trendingTweetText.text = @"Not loaded";
        //return cell;
    }
    TrendingTweetsAroundMeTableViewCell *cell = [tableView
                                    dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    //int row = [indexPath row];
    NSDictionary *tweet = self.tweets[[indexPath row]];
    cell.trendingTweetText.text = tweet[@"text"];
    NSString *profilePicUrl = tweet[@"user" ][@"profile_image_url"];
    NSDictionary *geo = tweet[@"geo"];
    NSLog(@"Geo got is : %@", geo);

    if (geo) {
        NSArray *coordinates = geo[@"coordinates"];
        NSLog(@"Geo values : %@", coordinates);
    }
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicUrl]];
    cell.trendingTweetProfilePic.image = [UIImage imageWithData:imageData];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
