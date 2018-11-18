//
//  NewsDetailController.m
//  News
//
//  Created by Burak Şentürk on 18.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import "NewsDetailController.h"

@interface NewsDetailController ()




@end

@implementation NewsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    self.navigationController.navigationBar.prefersLargeTitles = NO;

}

- (void)setupUI {
    self.newsImageView.image = [UIImage imageWithData:self.data];
    self.newsImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.newsTextView.text = [self convertHTML:self.text];
    
}

-(NSString *)convertHTML:(NSString *)html {
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}


@end
