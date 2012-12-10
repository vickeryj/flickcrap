//
//  FlickrFeedItem.h
//  flickcrap
//
//  Created by Joshua Vickery on 12/10/12.
//  Copyright (c) 2012 Joshua Vickery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrFeedItem : NSObject

+ (NSArray *)feedItemsFromJSON:(id)feedJSON;

- (NSString *)title;
- (NSURLRequest *)imageRequest;


@end
