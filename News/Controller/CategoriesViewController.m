//
//  CategoriesViewController.m
//  News
//
//  Created by Burak Şentürk on 12.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import "CategoriesViewController.h"
#import "Colors.h"
#import "NewsController.h"
@interface CategoriesViewController ()

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *categories;

@property(nonatomic,assign) float delay;
@property (weak ,nonatomic) IBOutlet UIImageView *image1;

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    for(int i = 0; i < self.categories.count; i++) {
        
        UIImageView *iv = self.categories[i];
        
        iv.alpha = 0;
     
        
    }
    
    Colors *colors = [[Colors alloc]init];
    
   self.view.backgroundColor = [colors rgb:255 green:204 blue:0];
    
//    self.view.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:204.0f/255.0f blue:0.0f/255.0f alpha:1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleNewsAction:)];
    
    [self.image1 addGestureRecognizer:tap];
    
}

- (void)handleNewsAction:(UITapGestureRecognizer *)recognizer {
    
    NewsController *newsController = [[NewsController alloc]init];
    UIStoryboard *storyboard = self.storyboard;
    
//    NSString *storyboardName = [storyboard valueForKey:@"Main"];
    
    newsController = [storyboard instantiateViewControllerWithIdentifier:@"NewsController"];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self.navigationController pushViewController:newsController animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    for(int i= 0; i< self.categories.count; i++) {
        
        UIImageView *imageView = self.categories[i];
        
        [self setAnimateImageViews:imageView delay:self.delay];
        
        self.delay += 0.5 ;
      
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