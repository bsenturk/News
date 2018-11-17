//
//  NewsCellTableViewCell.m
//  News
//
//  Created by Burak Şentürk on 17.11.2018.
//  Copyright © 2018 DevApp. All rights reserved.
//

#import "NewsCellTableViewCell.h"

@implementation NewsCellTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
