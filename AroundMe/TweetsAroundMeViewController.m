//
//  TweetsAroundMeViewController.m
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import "TweetsAroundMeViewController.h"
#import "TweetsAroundMe.h"
#import "TweetsAroundMeViewCell.h"
#import "GetCurrentLocation.h"
#import "WOEIDUtil.h"

@interface TweetsAroundMeViewController ()
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) TweetsAroundMe *tweetsAroundMe;
@end

@implementation TweetsAroundMeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    [self fetchTweets];
    return self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchTweets];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchTweets];
    
}

- (TweetsAroundMe *) tweetsAroundMe
{
    if (!_tweetsAroundMe) _tweetsAroundMe = [[TweetsAroundMe alloc]init];
    return _tweetsAroundMe;
}

- (NSArray *) tweets
{
    NSString *location = [GetCurrentLocation getCurrentLocation];
    if (!_tweets) _tweets = [self.tweetsAroundMe fetchTweets:location];
    return _tweets;
}

// Fetch tweets from tweetsAroundMe and populate tweets
- (void) fetchTweets
{
    NSString *location = [GetCurrentLocation getCurrentLocation];
    self.tweets = [self.tweetsAroundMe fetchTweets:location];
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
    //return self.tweets.count;
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"tweetTableCell";
    TweetsAroundMeViewCell *cell = [tableView
                              dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    //int row = [indexPath row];
    NSDictionary *tweet = self.tweets[[indexPath row]];
    cell.tweetTextView.text = tweet[@"text"];
    NSString *profilePicUrl = tweet[@"user" ][@"profile_image_url"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicUrl]];
    cell.tweetProfilePic.image = [UIImage imageWithData:imageData];
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
