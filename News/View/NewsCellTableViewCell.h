//
//  NewsCellTableViewCell.h
//  News
//
//  Created by Burak Şentürk on 17.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"
@interface NewsCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak , nonatomic) IBOutlet UILabel *newsDescriptionLabel;
@property(strong ,nonatomic) NSMutableArray <News *> *newsArray;
@end
