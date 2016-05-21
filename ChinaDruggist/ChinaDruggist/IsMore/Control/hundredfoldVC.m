//
//  hundredfoldVC.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "hundredfoldVC.h"
#import "IphonemarkViewController.h"
#import "ipAddreasVC.h"
@interface hundredfoldVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSMutableArray *_dataarr;
    NSMutableArray *_imagearr;
    UIView *ContenView;

}

@end



@implementation hundredfoldVC
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatview];
    [self creataedata];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.tabBarController.tabBar.hidden=YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    self.tabBarController.tabBar.hidden=NO;

}


-(void)creataedata{
    _dataarr=[NSMutableArray arrayWithArray:@[@"号码查询",@"IP地址查询"]];
    _imagearr=[NSMutableArray arrayWithArray:@[@"iconfont-shoujihaoma",@"iconfont-ip-2"]];
}

-(void)creatview{
    UICollectionViewFlowLayout *lay=[[UICollectionViewFlowLayout alloc]init];
    lay.itemSize=CGSizeMake(80, 112);
    lay.sectionInset=UIEdgeInsetsMake(30, 20, 50, 20);
    lay.minimumLineSpacing=50;
    lay.minimumLineSpacing=20;
    UICollectionView *view=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:lay];
    view.backgroundColor=[UIColor whiteColor];
    view.delegate=self;
    view.dataSource=self;
    [view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:view];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataarr.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(cell.frame.size.width/4, (cell.frame.size.height-32)/4, cell.frame.size.width/2, (cell.frame.size.height-32)/2)];
    image.image=[UIImage imageNamed:_imagearr[indexPath.item] ];
    UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, image.frame.size.height+image.frame.origin.y, cell.frame.size.width, 32)];
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font=[UIFont boldSystemFontOfSize:15];
    lable.text=_dataarr[indexPath.item];
    cell.backgroundColor=[UIColor lightGrayColor];
    [cell.contentView addSubview:image];
    [cell.contentView addSubview:lable];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.item) {
        case 0:
        {
            IphonemarkViewController *ipvc=[[IphonemarkViewController alloc]init];
            [self.navigationController pushViewController:ipvc animated:YES];
        }
            break;
        case 1:
        {
            ipAddreasVC *ipvc=[[ipAddreasVC alloc]init];
            [self.navigationController pushViewController:ipvc animated:YES];

        }
            break;
        default:
            break;
    }
}
-(void)createContenView{
    ContenView=[[UIView alloc]initWithFrame:self.view.bounds];

}


@end
