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
#import "TweetsAroundMeSingleton.h"


@interface TrendingTweetAroundMeTableViewController ()
@property (strong, nonatomic) NSArray *tweets;
@end

@implementation TrendingTweetAroundMeTableViewController

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

// Fetch tweets from tweetsAroundMe and populate tweets
- (void) fetchTweets
{
    TweetsAroundMeSingleton *sharedInstance = [TweetsAroundMeSingleton sharedInstance];
    self.tweets = [sharedInstance fetchTrendingTweets];
    //self.tweets = [sharedInstance fetchTweets];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"self.tweets size is : %d", self.tweets.count);
    NSLog(@"Inside tableView");
    static NSString *CellIdentifier = @"trendingTweetsCell";
    
    TrendingTweetsAroundMeTableViewCell *cell = [tableView
                                    dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    //int row = [indexPath row];
    //NSLog(@"Inside tableView after deque cell");
    NSDictionary *tweet = self.tweets[[indexPath row]];

   // NSLog(@" Dumping entire tweet : %@", tweet);
   // cell.trendingTweetText.text = tweet[@"text"];
    NSLog(@"Inside tableView after after tweet fetch");

    NSString *profilePicUrl = tweet[@"user" ][@"profile_image_url"];
    //NSLog(@"Inside tableView after after profile image url fetch");

    
    if (nil == profilePicUrl || [NSNull null] == (id)profilePicUrl) {
        NSLog(@"Ah Sucker 2!!");
    } else {
    
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:profilePicUrl]];
        cell.trendingTweetProfilePic.image = [UIImage imageWithData:imageData];
    }
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
