//
//  FoodViewController.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "FoodViewController.h"
#import "LFFoodTableViewcController.h"
@interface FoodViewController ()
{
}
@property (nonatomic,strong)LFFoodTableViewcController* lfview;
@property (nonatomic,assign) CGRect leftFrame;//记录手指刚开始触摸时左边视图控制器的view 的位置
@property (nonatomic,assign) CGRect centerFrame;//记录手指刚开始触摸时中间视图控制器的view 的位置

@property(nonatomic,strong) NSMutableArray *effectlist;//疗效列表
@property(nonatomic,strong) NSMutableArray *functionlist;//功能列表
@end
@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setbackview];
    [self registerNotification];

}
-(void)setbackview{
    UIImageView *backview=[[UIImageView alloc]initWithFrame:self.view.bounds];
    backview.image=[UIImage imageNamed:@"bg1.jpg"];
    [self.view addSubview:backview];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.tabBarController.tabBar.hidden=NO;
     self.navigationController.navigationBar.hidden=NO;
}


-(id)initWithLeftViewController:(UIViewController *)left andCenterViewController:(UIViewController *)center{
    self = [super init];
    if (self) {
        _left = left;
        //[(LFFoodTableViewcController*)_left getData];
        _center = center;
        //添加子视图控制器
        [self addChildViewController:_left];
        [self addChildViewController:_center];

        //添加子视图控制器的view
        [self.view addSubview:_left.view];
        [self.view addSubview:_center.view];
        //设置子视图控制器的vie的frame
        _left.view.frame = CGRectMake(-self.view.frame.size.width, 0,100, self.view.frame.size.height);
        _center.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    return self;
}
-(void)registerNotification{
    //注册收到隐藏侧边栏的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hide:) name:@"TOGGER" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playLeft) name:@"playLeft" object:nil];
}
-(void)playLeft{
    [UIView animateWithDuration:0.25 animations:^{
        _left.view.frame = CGRectMake(130-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        _center.view.frame = CGRectMake(130, 0, self.view.frame.size.width, self.view.frame.size.height);
         }];
}
//收到通知的回调函数
-(void)hide:(NSNotification *)no{
    [self hideLeft];
}
//隐藏左边的
-(void)hideLeft{
    [UIView animateWithDuration:0.25 animations:^{
        _left.view.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        _center.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];

}

@end
