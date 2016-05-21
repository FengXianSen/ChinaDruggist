//
//  Food_2viewController.h
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "footmodel.h"
#import "footmodel+footmodelReququData.h"

@protocol Food_2viewControllerdelete <NSObject>
-(void)relodatable;
@end

@interface Food_2viewController : UIViewController
@property(nonatomic,copy)NSString* foodID;
@property (nonatomic,strong)footmodel *modelfoot;
@property(nonatomic,strong)id<Food_2viewControllerdelete>deleget;
@end
