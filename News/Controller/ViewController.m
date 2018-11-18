//
//  ViewController.m
//  News
//
//  Created by Burak Şentürk on 10.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import "ViewController.h"
#import "CategoriesViewController.h"
#import "Colors.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(weak ,nonatomic) IBOutlet UIButton *skipButton;
@property (weak,nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak,nonatomic) IBOutlet UILabel *infoLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    Colors *colors = Colors.new;
    self.view.backgroundColor = [colors rgb:255 green:204 blue:0]; //self.bgColor;
   
    self.backgroundImage.image = [UIImage imageNamed:self.imgName];
    self.infoLabel.text = self.labelText;
    self.infoLabel.textColor = UIColor.whiteColor;
    self.pageControl.currentPage = self.pageIndex;
    self.skipButton.alpha = 0;
    if (self.pageIndex == 2) {
        
        self.skipButton.alpha = 1;
        
    }

}
- (IBAction)skipButton:(UIButton *)sender {
    CategoriesViewController *categoriesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoriesViewController"];
    
    UINavigationController *rootVC = [[UINavigationController alloc]initWithRootViewController:categoriesViewController];
    [rootVC setNavigationBarHidden:YES animated:YES];
    
    [self presentViewController:rootVC animated:YES completion:NULL];
    
}


  



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
