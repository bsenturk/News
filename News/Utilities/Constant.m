//
//  Constant.m
//  News
//
//  Created by Burak Şentürk on 17.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import "Constant.h"
#import "Constant.h"
@implementation Constant

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.baseUrl = @"https://api.hurriyet.com.tr/v1/search/";
        self.apiKey = @"c53e48cbadca4bf88fc41d43d2d48f29";
    }
    return self;
}



@end
