//
//  PageViewController.m
//  News
//
//  Created by Burak Şentürk on 10.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import "PageViewController.h"
#import "ViewController.h"
@interface PageViewController ()
@property (strong , nonatomic) NSMutableArray *viewControllerList;

@property NSArray *bgColors;
@property NSArray *imagesName;
@property NSArray *labelText;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _bgColors = @[UIColor.redColor, UIColor.greenColor, UIColor.blueColor];
    self.imagesName = @[@"newspaper-2",@"category" ,@"feedback"];
    self.labelText = @[@"En güncel haberlere kolayca erişin" , @"5 farklı kategorideki haberler" , @"Keyifli okumalar"];
    self.dataSource = self;
    
    ViewController *initialVC = (ViewController *)[self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialVC];
    
    
    [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

- (UIViewController *)viewControllerAtIndex: (NSUInteger)index {
    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"vc1"];
    if(index < 3) {
    viewController.bgColor = self.bgColors[index];
        viewController.imgName = self.imagesName[index];
        viewController.labelText = self.labelText[index];
        viewController.pageIndex = index;
        
        return viewController;

    }
    
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((ViewController *) viewController).pageIndex;

    
    if (index == NSNotFound) {
        return nil;
    }
    
    if (index == self.bgColors.count) {
        return nil;
    }
    index++;
 
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
      NSUInteger index = ((ViewController *) viewController).pageIndex;
    
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    
    return [self viewControllerAtIndex:index];
}

@end
