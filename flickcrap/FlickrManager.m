//
//  FlickrManager.m
//  flickcrap
//
//  Created by Joshua Vickery on 12/10/12.
//  Copyright (c) 2012 Joshua Vickery. All rights reserved.
//

#import "FlickrManager.h"
#import "AFNetworking.h"
#import "FlickrJSONRequestOperation.h"
#import "FlickrFeedItem.h"

@interface FlickrManager()

@property (strong, nonatomic) AFHTTPClient *client;

@end

@implementation FlickrManager

- (id)init
{
    self = [super init];
    if (self) {
        self.client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://api.flickr.com/services/feeds/photos_public.gne?format=json"]];
        [FlickrJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObjects:@"application/x-javascript", nil]];
        [self.client setDefaultHeader:@"Accept" value:@"application/x-javascript"];
        [self.client registerHTTPOperationClass:[FlickrJSONRequestOperation class]];
    }
    return self;
}


- (void)fetchFeedWithCallback:(void (^)(NSArray *flickrItems))callbackBlock
{
    [self.client getPath:nil
              parameters:nil
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     callbackBlock([FlickrFeedItem feedItemsFromJSON:[responseObject valueForKey:@"items"]]);
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     callbackBlock(nil);
                 }];
}


@end
