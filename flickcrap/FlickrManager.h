//
//  FlickrManager.h
//  flickcrap
//
//  Created by Joshua Vickery on 12/10/12.
//  Copyright (c) 2012 Joshua Vickery. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrManager : NSObject

- (void)fetchFeedWithCallback:(void (^)(NSArray *flickrItems))callbackBlock;

@end
