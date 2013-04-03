//
//  TweetsAroundMe.m
//  AroundMe
//
//  Created by Lohit VijayaRenu on 4/2/13.
//  Copyright (c) 2013 Lohit VijayaRenu. All rights reserved.
//

#import "TweetsAroundMe.h"
#import "GetCurrentLocation.h"
#import "WOEIDUtil.h"
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>

@interface TweetsAroundMe()
@property (strong, nonatomic) NSArray *tempTrends;
@property (strong, nonatomic) NSArray *tempTrendingTweets;
@end

@implementation TweetsAroundMe


- (NSArray *)fetchTweets:(NSString *)aroundLocation
{
    //NSMutableArray *returnTweets = [[NSMutableArray alloc]init];
    [self getTweetsNearLocation:aroundLocation];
    //[returnTweets addObjectsFromArray:self.tweets];
    return self.tweets;
}

- (NSArray *)fetchTrendingTweets:(NSString *) aroundLocation :(NSString *)aroundWOEID
{
    //_tempTrends = nil; // Let it allocate and populate again
    [self getTrends:aroundWOEID];
    if (self.tempTrends.count > 1) {
       // NSLog(@"_tempTrends : %@", self.tempTrends);
        
        NSMutableString *queryString = [[NSMutableString alloc]init];
        for (int i=0; i < self.tempTrends.count ; i++) {
            if (i == 0) {
                [queryString appendString:self.tempTrends[i]];
            } else {
                [queryString appendFormat:@" OR %@", self.tempTrends[i]];
            }
        }
       // NSLog(@"Query String is : %@", queryString);
        [self getTweetsNearLocation:aroundLocation :aroundWOEID];
    }
        
    return _tempTrendingTweets;
}



- (void)getTrends :(NSString *)aroundWOEID
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType
                                     options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             //NSLog(@"Inside aroundWOEID Granted!");
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 //NSLog(@"Testing aroundWOEID for account %@", twitterAccount.accountDescription);
                 
                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/trends/place.json"];
                // NSLog(@"Making request for URL : %@", requestURL);
                 
                 NSMutableDictionary *parameters =
                 [[NSMutableDictionary alloc] init];
                 [parameters setObject:aroundWOEID forKey:@"id"];
                 [parameters setObject:@"1" forKey:@"exclude"];
                 
                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:parameters];
                // NSLog(@"Making request : %@", postRequest.URL.debugDescription);
                 
                 postRequest.account = twitterAccount;
                 
                 [postRequest performRequestWithHandler:
                  ^(NSData *responseData, NSHTTPURLResponse
                    *urlResponse, NSError *error)
                  {
                      NSArray *tmpA =
                        [NSJSONSerialization
                                           JSONObjectWithData:responseData
                                           options:NSJSONReadingMutableLeaves
                                           error:&error];
                                           
                      
                      if (tmpA.count != 0) {
                          NSMutableArray *tempArray = [[NSMutableArray alloc]init];
                          
                          for (NSDictionary *a in tmpA) {
                              if (nil == a || [NSNull null] == (id) a) {
                                  continue;
                              }
                              NSArray *trends = a[@"trends"];
                              if (nil == trends || [NSNull null] == (id) trends) {
                                  continue;
                              }
                              for (NSDictionary *a2 in trends) {
                                  [tempArray addObject:a2[@"name"]];
                              }
                          }
                          self.tempTrends = [NSArray arrayWithArray:tempArray];
                          //NSLog(@"dataSource aroundWOEID count : %d", self.tweets.count);
                          //NSLog(@"dataSource aroundWOEID count : description %@", self.tempTrends.description);
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

- (void)getTweetsNearLocation:(NSString *)aroundLocation :(NSString *)queryString
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType
                                     options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             //NSLog(@"Inside Location Query Granted!");
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 //NSLog(@"Testing Location for account %@", twitterAccount.accountDescription);
                 
                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
                 //NSLog(@"Making request for URL : %@", requestURL);
                 
                 NSMutableDictionary *parameters =
                 [[NSMutableDictionary alloc] init];
                 [parameters setObject:@"20" forKey:@"count"];
                 [parameters setObject:queryString forKey:@"q"];
                 [parameters setObject:aroundLocation forKey:@"geocode"];
                 [parameters setObject:@"1" forKey:@"include_entities"];
                 
                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:parameters];
                 //NSLog(@"Making request : %@", postRequest.URL.debugDescription);
                 
                 postRequest.account = twitterAccount;
                 
                 [postRequest performRequestWithHandler:
                  ^(NSData *responseData, NSHTTPURLResponse
                    *urlResponse, NSError *error)
                  {
                      NSDictionary *dic = [NSJSONSerialization
                                           JSONObjectWithData:responseData
                                           options:NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments
                                           error:&error];
                      self.tempTrendingTweets = dic[@"statuses"];
                      
                      //NSLog(@"Error code got : %@", error.description);
                      if (self.tempTrendingTweets.count != 0) {
                          //       NSLog(@"dataSource count : %d", self.tweets.count);
                           //     NSLog(@"dataSource count : description %@", self.tempTrendingTweets.description);
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
             //NSLog(@"Inside Location Granted!");
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                 //NSLog(@"Testing Location for account %@", twitterAccount.accountDescription);
                 
                 NSURL *requestURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
                 //NSLog(@"Making request for URL : %@", requestURL);
                 
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
                 //NSLog(@"Making request : %@", postRequest.URL.debugDescription);
                 
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
                   //       NSLog(@"dataSource count : %d", self.tweets.count);
                    //      NSLog(@"dataSource count : description %@", self.tweets.description);
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
