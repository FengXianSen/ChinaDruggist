//
//  FoodTableViewController.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/10.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "FoodTableViewController.h"
#import "footmodel.h"
#import "footmodel+footmodelReququData.h"
#import "FoodTableViewCell.h"
#import "Food_2viewController.h"
#import "seachViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
@interface FoodTableViewController ()<UITextFieldDelegate,Food_2viewControllerdelete,UIAlertViewDelegate>
{
    UITextField *textfield;
    NSInteger _pagerIndex;//加载页
    UITableView *_tabView;//加载列表
    UICollectionView *collectVW;
    UIButton *lbarbtn;
    UIButton *lbarbtnmain;//左导航
    UIButton *Rbarbtn;//右导航
    BOOL iscollect;//是否收藏
    footmodel *model;
    NSString *DataPath;

}
@property(nonatomic,strong) NSMutableArray *footArray;//食品列表

@property(nonatomic,strong) NSMutableArray *searchArray;
@property(nonatomic,strong) UIActivityIndicatorView*active;
@end
@implementation FoodTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _pagerIndex=1;
    iscollect=NO;
    model=[footmodel sharefootmodel];
    _searchArray=[[NSMutableArray alloc]init];
    _footArray=[[NSMutableArray alloc]init];
    DataPath=foot_path;
    [self createNavication];
    [self notifycation];
    [self chab];
    [self createRefresh];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{


}

-(void)chab{
    //1.获得
    AFHTTPRequestOperationManager *mag=[AFHTTPRequestOperationManager manager];
    [mag.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSArray *arr=@[@"不知道",@"没网",@"GPRS",@"wifi"];

        if (status>0) {
              [self createData];
        }else{
            UIAlertView *all=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:arr[status+1] delegate:self cancelButtonTitle:@"好的" otherButtonTitles:@"不", nil];
            all.delegate=self;
            [self.view addSubview:all];
            [all show];
        }
    }];
    [mag .reachabilityManager startMonitoring];
}






-(void)createRefresh{
    MJRefreshHeader *head=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (_footArray.count>0) {
            [_footArray removeAllObjects];
        }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                _pagerIndex=1;
                [self createData];
        });
}];



self.tableView.header=head;


//    MJRefreshAutoNormalFooter*ftood=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            _pagerIndex++;
//            [self createData];
//
//        });
//    }];

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

    // 设置文字
    [footer setTitle:@"全部加载完成" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];


    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];

    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];

    // 设置footer
    self.tableView.footer=footer;
}
-(void)loadMoreData{

    _pagerIndex++;
    [self createData];

}








-(void)createData{
    [self.view addSubview: self.active];
    [self.active startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [model requestDataBlock:1 DataPath:[DataPath stringByAppendingFormat:@"&page=%ld",_pagerIndex]   block:^(NSArray *arr, NSError *erro) {
            if (arr.count<=0) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                 [self.active stopAnimating];
                [self.tableView.footer endRefreshing];
                 });

            }else{
                [self.footArray addObjectsFromArray:arr];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (erro==nil) {
                        [self.tableView reloadData];
                        [self.tableView.footer endRefreshing];
                        [self.active stopAnimating];
                        [self.tableView.header endRefreshing];
                    }
                    else{
                        NSLog(@"%@",erro);
                    }
                });
            }

        }];
    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.footArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    FoodTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell=[[FoodTableViewCell alloc]init];
    }
    cell.model=self.footArray[indexPath.row];
    cell.layer.cornerRadius=10;
    cell.layer.masksToBounds=YES;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    Food_2viewController *f2VC=[[Food_2viewController alloc]init];
    footmodel*md=self.footArray[indexPath.row];
    f2VC.foodID=md.idapp;
    f2VC.modelfoot=md;
    f2VC.deleget=self;
    [self.navigationController pushViewController:f2VC animated:YES];


    [[NSNotificationCenter defaultCenter]postNotificationName:@"TOGGER" object:nil userInfo:nil];
    [self setiscollect];

}
-(void)createNavication{
    self.navigationItem.title=@"首页";
    self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"中草科普" image:[UIImage imageNamed:@"iconfont-shicai"] selectedImage:[[UIImage imageNamed:@"iconfont-shicai-2"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];


    lbarbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    lbarbtn.frame=CGRectMake(0,9,16, 16);
    lbarbtn.tag=1000;
    [lbarbtn setImage:[UIImage imageNamed:@"iconfont-caidan-4"] forState:UIControlStateNormal];
    [lbarbtn setImage:[UIImage imageNamed:@"iconfont-caidan-3"] forState:UIControlStateHighlighted];
    [lbarbtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];

    lbarbtnmain=[UIButton buttonWithType:UIButtonTypeCustom];
    lbarbtnmain.frame=CGRectMake(0,9,16, 16);
    lbarbtnmain.tag=1001;
    [lbarbtnmain setImage:[UIImage imageNamed:@"iconfont-zhuye-2"] forState:UIControlStateNormal];
    [lbarbtnmain setImage:[UIImage imageNamed:@"iconfont-zhuye"] forState:UIControlStateHighlighted];
    [lbarbtnmain addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];





    Rbarbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    Rbarbtn.frame=CGRectMake(0,9,16, 16);
    Rbarbtn.tag=1002;
    [Rbarbtn setImage:[UIImage imageNamed:@"iconfont-sousuo-2"] forState:UIControlStateNormal];
    [Rbarbtn setImage:[UIImage imageNamed:@"iconfont-sousuo"] forState:UIControlStateHighlighted];
    [Rbarbtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:Rbarbtn];

    self.navigationItem.leftBarButtonItems=@[[[UIBarButtonItem alloc]initWithCustomView:lbarbtn],[[UIBarButtonItem alloc]initWithCustomView:lbarbtnmain]];
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:0.22 green:0.235 blue:0.49 alpha:1];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"TOGGER" object:nil];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:@"playLeft" object:nil];
}

-(void)notifycation{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TOGGER" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setiscollect) name:@"chagevalue" object:nil];
   [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tablerload:) name:@"tablerload" object:nil];
      [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tablerloadBarData:) name:@"tablerloadBar" object:nil];
}





-(void)tablerload:(NSNotification*)notify{
    _pagerIndex=1;
    DataPath=foot_effect(notify.userInfo[@"id"]);
    if (self.footArray.count>0) {
        [self.footArray removeAllObjects];
    }
    [self createData];
}
-(void)tablerloadBarData:(NSNotification*)notify{
     _pagerIndex=1;
    DataPath=foot_function(notify.userInfo[@"id"]);
    if (self.footArray.count>0) {
        [self.footArray removeAllObjects];
    }

    [self createData];
}

-(void)setiscollect{
    iscollect=NO;
}
-(void)click:(UIButton*)btn{
    if (btn.tag==1000) {
        if (iscollect) {
            [self notifycation];
            iscollect=NO;
        }else{
            [[NSNotificationCenter defaultCenter]postNotificationName:@"playLeft" object:nil userInfo:nil];
            iscollect=YES;
        }

    }else if (btn.tag==1001){
        if (_footArray.count>0) {
            [_footArray removeAllObjects];
        }
        _pagerIndex=1;
        DataPath=foot_path;
        [self createData];
    }else if (btn.tag==1002){
        seachViewController *sch=[[seachViewController alloc]init];
        [self.navigationController pushViewController:sch animated:YES];
    }
}

-(void)relodatable{

    [self.tableView reloadData];
}
-(UIActivityIndicatorView *)active{
    if (_active==nil) {
        _active=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _active.center=self.view.center;
        _active.layer.transform=CATransform3DMakeScale(2, 2, 0);

    }
    return _active;

}



@end
