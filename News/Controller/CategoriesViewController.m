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

@property(nonatomic,assign) float delay;

    @property (strong, nonatomic) IBOutletCollection(UIView) NSArray *categoryCollection;
    @property (weak, nonatomic) IBOutlet UIView *iv1;
    @property (weak, nonatomic) IBOutlet UIView *iv2;
    @property (weak, nonatomic) IBOutlet UIView *iv3;
    @property (weak, nonatomic) IBOutlet UIView *iv4;
    @property (weak, nonatomic) IBOutlet UIView *iv5;
    @property UIView *iv;
@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    for(int i = 0; i < self.categoryCollection.count; i++) {
        
         self.iv = self.categoryCollection[i];
        
        self.iv.alpha = 0;
        self.iv.backgroundColor = UIColor.clearColor;
        self.iv.layer.cornerRadius = 5.0f;
        self.iv.layer.borderColor = [UIColor whiteColor].CGColor;
        self.iv.layer.borderWidth = 3.0f;
     
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleNewsAction:)];
        NSString *name = [NSString stringWithFormat:@"%d", i];
        tap.name = name;
        [self.iv addGestureRecognizer:tap];
    }
    
    Colors *colors = [[Colors alloc]init];
    
   self.view.backgroundColor = [colors rgb:255 green:204 blue:0];
    
//    self.view.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:204.0f/255.0f blue:0.0f/255.0f alpha:1];
    
    
    
}

- (void)handleNewsAction:(UITapGestureRecognizer *)recognizer {
    
    NewsController *newsController = [[NewsController alloc]init];
    UIStoryboard *storyboard = self.storyboard;
    
//    NSString *storyboardName = [storyboard valueForKey:@"Main"];
    
    newsController = [storyboard instantiateViewControllerWithIdentifier:@"NewsController"];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    if ([recognizer.name  isEqual: @"0"]) {
        newsController.categoryName = @"Gundem";
    }
    else if ([recognizer.name isEqual:@"1"]) {
        newsController.categoryName = @"Ekonomi";
    }
    else if ([recognizer.name isEqual:@"2"]) {
        newsController.categoryName = @"Dunya";
    }
    else if ([recognizer.name isEqual:@"3"]) {
        newsController.categoryName = @"Spor";
    }
    else if ([recognizer.name isEqual:@"4"]) {
        newsController.categoryName = @"Magazin";
    }
    [self.navigationController pushViewController:newsController animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    for(int i= 0; i< self.categoryCollection.count; i++) {
        
        UIView *categoryView = self.categoryCollection[i];
        
        [self setAnimateImageViews:categoryView delay:self.delay];
        
        self.delay += 0.5 ;
      
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAnimateImageViews:(UIView *)iv delay:
                        (float)delay {
    
    [UIView animateWithDuration:0.4 delay:self.delay options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        
        iv.alpha = 1;
        
    } completion:nil];
}



@end
