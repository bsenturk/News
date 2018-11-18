//
//  NewsController.m
//  News
//
//  Created by Burak Şentürk on 17.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import "NewsController.h"
#import "NewsCellTableViewCell.h"
#import "Colors.h"
#import "Constant.h"
#import "News.h"
#import "NewsDetailController.h"

@interface NewsController ()
@property NSString *cellId;
@property (weak , nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray<News *> *newsArray;
@property (strong , nonatomic) UIActivityIndicatorView *actIndicator;
@property (strong , nonatomic) UIView *wtView;
@property NSString *categoryName;

@end

@implementation NewsController

static BOOL isLoad;
static BOOL isBack;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.cellId = @"newsCellId";
    isLoad = NO;
    isBack = YES;
    self.categoryName = @"Magazin";
    
    NSString *count = @"?$top=15";
    
    self.navigationItem.title = self.categoryName;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
 
    self.navigationController.navigationBar.largeTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
   
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    NSString *countParameter = [NSString stringWithFormat:@"%@%@",self.categoryName,count];
    
    [self fetchNews:countParameter];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"newsCellId"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupProgressOfNews];
    
    
    
}

-(void)setupProgressOfNews{

    
    UIView *waitView = UIView.new;
    [self.view addSubview:waitView];
    waitView.translatesAutoresizingMaskIntoConstraints = false;
    waitView.backgroundColor = UIColor.grayColor;
    waitView.layer.cornerRadius = 5;
    [waitView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [waitView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [waitView.heightAnchor constraintEqualToConstant:100].active = YES;
    [waitView.widthAnchor constraintEqualToConstant:100].active = YES;
    self.wtView = waitView;
    UIActivityIndicatorView *activityIndicator = UIActivityIndicatorView.new;
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false;
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [waitView addSubview:activityIndicator];
    
    [activityIndicator.centerYAnchor constraintEqualToAnchor:waitView.centerYAnchor].active = YES;
    [activityIndicator.centerXAnchor constraintEqualToAnchor:waitView.centerXAnchor].active = YES;
    
    [activityIndicator startAnimating];
    self.actIndicator = activityIndicator;
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Colors *bgColor = [[Colors alloc]init];
    
    self.navigationController.navigationBar.barTintColor = [bgColor rgb:255 green:204 blue:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(isBack == YES) {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    }else {
         [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

    
   
    
}

- (void)fetchNews:(NSString *)categoryName {
    
    Constant *constant = Constant.new;
    
  //  urlName = constant.baseUrl;
    
    NSString *urlName = [NSString stringWithFormat:@"%@%@",constant.baseUrl,categoryName];
    
    
    NSURL *url = [[NSURL alloc]initWithString:urlName];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    
    request.timeoutInterval = 60.00;
    
    [request setValue:constant.apiKey forHTTPHeaderField:@"apikey"];
 
    
    [[NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"Fetching news...");
        
        NSError *err;
        
        if(err) {
            NSLog(@"Failed to fetch news.: %@",err);
        }
        
        
        NSMutableArray <News *> *newsArr = NSMutableArray.new;
        
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        NSDictionary *listDict = [dict objectForKey:@"List"];
        
       // NSLog(@"List objects. : %@",listDict);
        
        for(NSDictionary *news in listDict) {
            
            NSString *desc = news[@"Description"];
            NSString *contentType = news[@"ContentType"];
            NSString *text = news[@"Text"];
            
              News *newsModel = News.new;
            
            newsModel.desc = desc;
            newsModel.contentType = contentType;
            newsModel.text = text;
            
            NSDictionary *imagesFiles = [news objectForKey:@"Files"];
            
            for(NSDictionary *img in imagesFiles) {
                
                NSString *images = img[@"FileUrl"];
                NSLog(@"images. : %@",images);
                newsModel.imageUrl = images;
            }
            
            
            if([contentType  isEqual: @"Article"]) {
            
            [newsArr addObject:newsModel];
            }
            
        }
        
        self.newsArray = newsArr;
       
      
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
           
            
        });
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.actIndicator stopAnimating];
            [self.wtView removeFromSuperview];
        });
        
        
    }] resume];
    
    
    
    
}



/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 250;
}*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsArray.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellId forIndexPath:indexPath];
   // cell = [[NewsCellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellId];

    News *news = self.newsArray[indexPath.row];
    cell.newsDescriptionLabel.text = news.desc;
    
    NSURL *imageUrl = [[NSURL alloc]initWithString:news.imageUrl];
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:imageUrl];
    
    cell.newsImageView.image = [UIImage imageWithData:imageData];
    
    

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailController *newsDetailController = [[NewsDetailController alloc]init];
    UIStoryboard *storyboard = self.storyboard;
    
    newsDetailController = [storyboard instantiateViewControllerWithIdentifier:@"NewsDetailController"];
    isBack = NO;
    News *news = self.newsArray[indexPath.row];
 
    NSURL *imageUrl = [[NSURL alloc]initWithString:news.imageUrl];
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:imageUrl];

    newsDetailController.text = news.text;
    newsDetailController.data = imageData;
    
    Colors *colors = Colors.new;
    self.navigationController.navigationBar.barTintColor = [colors rgb:255 green:204 blue:0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:newsDetailController animated:YES];
}




@end
