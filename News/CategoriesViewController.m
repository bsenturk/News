//
//  CategoriesViewController.m
//  News
//
//  Created by Burak Şentürk on 12.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import "CategoriesViewController.h"

@interface CategoriesViewController ()

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *categories;

@property(nonatomic,assign) float delay;

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    for(int i = 0; i < self.categories.count; i++) {
        
        UIImageView *iv = self.categories[i];
        
        iv.alpha = 0;
     
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    for(int i= 0; i< self.categories.count; i++) {
        
        UIImageView *imageView = self.categories[i];
        
        [self setAnimateImageViews:imageView delay:self.delay];
        
        self.delay += 0.5 ;
        NSString *str = [NSString stringWithFormat:@"%ld",(long)self.delay];
        
        NSLog(@"%@",str);
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAnimateImageViews:(UIImageView *)iv delay:
                        (float)delay {
    
    [UIView animateWithDuration:0.4 delay:self.delay options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        
        iv.alpha = 1;
        
    } completion:nil];
}



@end
