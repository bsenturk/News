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
@interface NewsController ()
@property NSString *cellId;
@property (weak , nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray<News *> *newsArray;

@property NSString *categoryName;

@end

@implementation NewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.cellId = @"newsCellId";
    
    self.categoryName = @"magazin";
    
    [self fetchNews:self.categoryName];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"newsCellId"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 250;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    Colors *bgColor = [[Colors alloc]init];
    
    self.navigationController.navigationBar.barTintColor = [bgColor rgb:255 green:204 blue:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
            
              News *newsModel = News.new;
            
            newsModel.desc = desc;
            
            NSDictionary *imagesFiles = [news objectForKey:@"Files"];
            
            for(NSDictionary *img in imagesFiles) {
                
                NSString *images = img[@"FileUrl"];
                NSLog(@"images. : %@",images);
                newsModel.imageUrl = images;
            }
            
            
            
            
            [newsArr addObject:newsModel];
            
        }
        
        self.newsArray = newsArr;
       
      
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
    }] resume];
    
    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 250;
}

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
    
    NSURL *imageUrl = [[NSURL alloc]initWithString:self.newsArray[indexPath.row].imageUrl];
    NSData *imageData = [[NSData alloc]initWithContentsOfURL:imageUrl];
    
    cell.imageView.image = [UIImage imageWithData:imageData];
    
    

    
    return cell;
    
}




@end
