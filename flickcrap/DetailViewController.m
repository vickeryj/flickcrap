//
//  DetailViewController.m
//  flickcrap
//
//  Created by Joshua Vickery on 12/10/12.
//  Copyright (c) 2012 Joshua Vickery. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "FlickrFeedItem.h"

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [self.feedItem title];
    
    NSURLRequest *imageRequest = [self.feedItem imageRequest];
    if (nil != imageRequest) {
        [self.imageView setImageWithURLRequest:imageRequest
                                  placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                      self.imageView.image = image;
                                      [self.imageView setNeedsDisplay];
                                  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                      
                                  }];
    }    
}


@end
