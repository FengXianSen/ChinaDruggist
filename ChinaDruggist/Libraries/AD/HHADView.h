//
//  HHADView.h
//  Tsss
//
//  Created by 郝海圣 on 15/10/6.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHADItem.h"
@interface HHADView : UIView<UIScrollViewDelegate>
@property (nonatomic,retain) NSArray *itemArray;
-(void)reloadData;
-(void)loadData;
@end
