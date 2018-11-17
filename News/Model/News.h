//
//  News.h
//  News
//
//  Created by Burak Şentürk on 17.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (strong,nonatomic) NSString *newsId;
@property (strong,nonatomic) NSString *contentType;
@property (strong,nonatomic) NSString *desc;
@property (strong,nonatomic) NSString *imageUrl;
@property (strong ,nonatomic) NSString *url;
@property (strong ,nonatomic) NSString *text;
@end
