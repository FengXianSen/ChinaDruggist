//
//  ViewController.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "ViewController.h"
#import "HHADView.h"
#import "FoodViewController.h"
#import "FoodTableViewController.h"
#import "LFFoodTableViewcController.h"
#import "IsMoreViewController.h"
#import "FoodViewController.h"
#define USERKEY @"isfirstKey"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self isFisrtStarApp]) {
        [self createScrollView];
    }else {
        [self changeView];
    }
}

-(void)createScrollView{

    HHADView *ave=[[HHADView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    ave.itemArray=@[@"SC1",@"SC2",@"SC3"];
    [ave loadData];
    [self.view addSubview:ave];

    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, self.view.frame.size.height-80, 150, 50)];
       [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=10;
    btn.layer.masksToBounds=YES;
    [btn setImage:[UIImage imageNamed:@"scBTN.jpg"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}
-(void)click:(UIButton*)btn{
 [self changeView];
}



-(BOOL)isFisrtStarApp{
    //获得单例
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //读取次数（用户上一次启动app的次数）
    NSString *number = [userDefaults objectForKey:USERKEY];
    //判断是否有值
    if (number!=nil) {
        //能够取到值，则不是第一次启动
        NSInteger starNumer = [number integerValue];
        //用上一次的次数+1次
        NSString *str = [NSString stringWithFormat:@"%ld",++starNumer];
        //存的是用户这一次启动的次数
        [userDefaults setObject:str forKey:USERKEY];
        [userDefaults synchronize];
        return NO;
    }else{
        //不能取到值，则是第一次启动
        [userDefaults setObject:@"1" forKey:USERKEY];
        [userDefaults synchronize];
        return YES;
    }
}



-(void)changeView{
    FoodTableViewController*rt=[[FoodTableViewController alloc]init];
    UINavigationController *clVC=[[UINavigationController alloc]initWithRootViewController:rt];
    LFFoodTableViewcController*LFtab=[[LFFoodTableViewcController alloc]initWithStyle:UITableViewStyleGrouped];
    UINavigationController *LFVC=[[UINavigationController alloc]initWithRootViewController:LFtab];


    IsMoreViewController*ismore=[[IsMoreViewController alloc]init];
    UINavigationController *isnVC=[[UINavigationController alloc]initWithRootViewController:ismore];
    ismore.title=@"更多";
    ismore.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"更多" image:[UIImage imageNamed:@"iconfont-gengduo"] selectedImage:[[UIImage imageNamed:@"iconfont-gengduo-2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];




    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    UITabBarController *TABvc=[[UITabBarController alloc]init];

    TABvc.viewControllers=@[clVC,isnVC];

    FoodViewController *ft=[[FoodViewController alloc]initWithLeftViewController:LFVC andCenterViewController:TABvc];






    [UIApplication sharedApplication].keyWindow.rootViewController=ft;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
