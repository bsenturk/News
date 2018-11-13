//
//  ViewController.m
//  News
//
//  Created by Burak Şentürk on 10.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import "ViewController.h"
#import "CategoriesViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.view.backgroundColor = self.bgColor;
   
    self.pageControl.currentPage = self.pageIndex;

}
- (IBAction)skipButton:(UIButton *)sender {
    CategoriesViewController *categoriesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CategoriesViewController"];
    [self presentViewController:categoriesViewController animated:YES completion:NULL];
    
}


  



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
