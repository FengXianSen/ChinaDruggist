//
//  SaveViewController.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "SaveViewController.h"
#import "ChinaTabDB.h"
#import "SeachCollectionViewCell.h"
#import "Food_2viewController.h"
@interface SaveViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

{
    ChinaTabDB *_tabDB;

}

@property(nonatomic,strong)NSArray *dataarr;
@property(nonatomic,strong)UICollectionView *coll;
@end

@implementation SaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabDB=[ChinaTabDB sharedChinaTabDB];
     [self cretadataview];
    [self cretadata];


}

-(void)cretadata{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       _dataarr=[_tabDB getInsertDBModels];
        dispatch_async(dispatch_get_main_queue(), ^{
           [_coll reloadData];
        });

    });
}
-(void)cretadataview{
    self.automaticallyAdjustsScrollViewInsets=NO;
        UICollectionViewFlowLayout*clfy=[[UICollectionViewFlowLayout alloc]init];
        clfy.itemSize=CGSizeMake(150, 200);
        clfy.sectionInset=UIEdgeInsetsMake(5,20, 5, 20);
        _coll =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, KScreeWidth, KScreeHeigth-64) collectionViewLayout:clfy];
        _coll.delegate=self;
        _coll.dataSource=self;
        _coll.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:_coll];

        [_coll registerClass:[SeachCollectionViewCell class]forCellWithReuseIdentifier:@"cell"];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return self.dataarr.count;
    }


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        SeachCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.footmodel=_dataarr[indexPath.item];
        return cell;
 }
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        Food_2viewController *fd2vc=[[Food_2viewController alloc]init];
    footmodel *model2=_dataarr[indexPath.item];
  fd2vc.foodID=model2.idapp ;
 [self.navigationController pushViewController:fd2vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;

}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
