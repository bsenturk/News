//
//  Colors.m
//  News
//
//  Created by Burak Şentürk on 14.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import "Colors.h"

@implementation Colors


-(UIColor *)rgb:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    
    
    
    UIColor *colors = [UIColor colorWithRed:(float)red/255.0f green:(float)green/255.0f blue:(float)blue/255.0f alpha:1.0f];
    
    return colors;
}



@end
