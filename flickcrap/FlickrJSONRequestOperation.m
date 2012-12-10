//
//  FlickrJSONRequestOperation.m
//  flickcrap
//
//  Created by Joshua Vickery on 12/10/12.
//  Copyright (c) 2012 Joshua Vickery. All rights reserved.
//

#import "FlickrJSONRequestOperation.h"

@interface FlickrJSONRequestOperation()

@property (readwrite, nonatomic, strong) id responseJSON;
@property (readwrite, nonatomic, strong) NSError *JSONError;

@end

@implementation FlickrJSONRequestOperation

@synthesize responseJSON = _responseJSON;

- (id)responseJSON {
    if (!_responseJSON && [self.responseData length] > 0 && [self isFinished] && !self.JSONError)
    {

        NSError *error = nil;
        if ([self.responseData length] > 15 && ![self.responseString isEqualToString:@" "]) {
            NSString *cleanedUpJSONString = [self.responseString stringByReplacingCharactersInRange:NSMakeRange(0, 15) withString:@""];
            cleanedUpJSONString = [cleanedUpJSONString stringByReplacingCharactersInRange:NSMakeRange([cleanedUpJSONString length]-1, 1) withString:@""];
            cleanedUpJSONString = [cleanedUpJSONString stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
            NSData *JSONData = [cleanedUpJSONString dataUsingEncoding:self.responseStringEncoding];
            self.responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:self.JSONReadingOptions error:&error];

        }
        self.JSONError = error;
    }
    return _responseJSON;
}

- (NSError *)error {
    if (self.JSONError) {
        return self.JSONError;
    } else {
        return [super error];
    }
}

@end
