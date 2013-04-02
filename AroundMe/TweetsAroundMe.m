//
//  TweetsAroundMe.m
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import "TweetsAroundMe.h"
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>

@interface TweetsAroundMe()
@end

@implementation TweetsAroundMe

- (NSArray *)fetchTweets:(NSString *)aroundLocation
{
    //NSMutableArray *returnTweets = [[NSMutableArray alloc]init];
    [self getTweetsNearLocation:aroundLocation];
    //[returnTweets addObjectsFromArray:self.tweets];
    return self.tweets;
}


- (void)getTweetsNearLocation:(NSString *)aroundLocation
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType
                                     options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             NSLog(@"Inside Location Granted!");
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 NSLog(@"Testing Location for account %@", twitterAccount.accountDescription);
                 
                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
                 NSLog(@"Making request for URL : %@", requestURL);
                 
                 NSMutableDictionary *parameters =
                 [[NSMutableDictionary alloc] init];
                 [parameters setObject:@"20" forKey:@"count"];
                 [parameters setObject:@"at" forKey:@"q"];
                 [parameters setObject:aroundLocation forKey:@"geocode"];
                 [parameters setObject:@"1" forKey:@"include_entities"];
                 
                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:parameters];
                 NSLog(@"Making request : %@", postRequest.URL.debugDescription);
                 
                 postRequest.account = twitterAccount;
                 
                 [postRequest performRequestWithHandler:
                  ^(NSData *responseData, NSHTTPURLResponse
                    *urlResponse, NSError *error)
                  {
                      //self.dataSource2 = [NSJSONSerialization
                      //                   JSONObjectWithData:responseData
                      //                  options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments
                      //                 error:&error];
                      NSDictionary *dic = [NSJSONSerialization
                                           JSONObjectWithData:responseData
                                           options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments
                                           error:&error];
                      self.tweets = dic[@"statuses"];
                      //for (NSDictionary *tweet in tweets) {
                      //    NSString *tweetText = tweet[@"text"];
                      //    NSLog(@"Tweet from location: %@", tweetText);
                      //}
                      
                      //NSLog(@"Error code got : %@", error.description);
                      if (self.tweets.count != 0) {
                          NSLog(@"dataSource count : %d", self.tweets.count);
                          NSLog(@"dataSource count : description %@", self.tweets.description);
                          dispatch_async(dispatch_get_main_queue(), ^{
                              // [self.tweetTableView reloadData];
                          });
                      }
                  }];
             }
         } else {
             // Handle failure to get account access
         }
     }];
}

@end
