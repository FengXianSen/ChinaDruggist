//
//  SeachCollectionViewCell.h
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeachModel.h"
#import "footmodel.h"
@interface SeachCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) SeachModel*model;

@property(nonatomic,strong)footmodel *footmodel;
@end
