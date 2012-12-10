//
//  FlickrFeedItem.m
//  flickcrap
//
//  Created by Joshua Vickery on 12/10/12.
//  Copyright (c) 2012 Joshua Vickery. All rights reserved.
//

#import "FlickrFeedItem.h"

@interface FlickrFeedItem()

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageURLString;

@end

@implementation FlickrFeedItem

+ (NSArray *)feedItemsFromJSON:(id)feedJSON {
    NSMutableArray *items = [NSMutableArray array];
    for (id json in feedJSON) {
        FlickrFeedItem *item = [[self alloc] init];
        item.title = [json valueForKey:@"title"];
        item.imageURLString = [json valueForKeyPath:@"media.m"];
        [items addObject:item];
    }
    return items;
}

- (NSURLRequest *)imageRequest {
    NSMutableURLRequest *imageRequest = nil;
    if (nil != self.imageURLString) {
        NSURL *imageURL = [NSURL URLWithString:self.imageURLString];
        if (nil != imageURL) {
            imageRequest = [NSMutableURLRequest requestWithURL:imageURL];
        }
    }
    return imageRequest;
}

@end
