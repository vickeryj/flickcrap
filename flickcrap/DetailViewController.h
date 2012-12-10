//
//  DetailViewController.h
//  flickcrap
//
//  Created by Joshua Vickery on 12/10/12.
//  Copyright (c) 2012 Joshua Vickery. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id feedItem;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
