//
//  FoodViewController.h
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodViewController : UIViewController
//左边的视图控制器
@property (nonatomic,strong ) UIViewController *left;
//中间主内容的视图控制器
@property (nonatomic,strong)  UIViewController *center;

-(id)initWithLeftViewController:(UIViewController *)left andCenterViewController:(UIViewController *)center;
@end
