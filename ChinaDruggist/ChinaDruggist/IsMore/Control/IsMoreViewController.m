//
//  IsMoreViewController.m
//  ChinaDruggist
//
//  Created by FengZC on 15/3/15.
//  Copyright (c) 2015年 FengZC. All rights reserved.
//

#import "IsMoreViewController.h"
#import "seachViewController.h"
#import "SaveViewController.h"
#import "peripheralViewController.h"
#import "feedbackViewController.h"
#import "UMFeedback.h"
#import "UMFeedbackViewController.h"
#import "hundredfoldVC.h"
@interface IsMoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate>
{
     UIButton *Rbarbtn;
    NSArray *arr;
    NSArray *imagearr;
    UIView *view;
}
@end

@implementation IsMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavication];
    [self createView];
}
-(void)creatNavication{
    Rbarbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    Rbarbtn.frame=CGRectMake(0,9,16, 16);
    Rbarbtn.tag=1002;
    [Rbarbtn setImage:[UIImage imageNamed:@"iconfont-sousuo-2"] forState:UIControlStateNormal];
    [Rbarbtn setImage:[UIImage imageNamed:@"iconfont-sousuo"] forState:UIControlStateHighlighted];
    [Rbarbtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:Rbarbtn];
}


-(void)createView{
    arr=@[@"我的收藏",@"百宝箱",@"清空缓存",@"周边药店",@"反馈我们",@"关于我们"];
    imagearr=@[@"iconfont-shoucang-6",@"iconfont-baoxiang",@"iconfont-qingli-4",@"iconfont-zhoubian",@"iconfont-fankui",@"iconfont-guanyu"];

    UICollectionViewFlowLayout *cly=[[UICollectionViewFlowLayout alloc]init];
    cly.itemSize=CGSizeMake(self.view.frame.size.width/2-20, 80);
    cly.minimumLineSpacing=10;
    cly.scrollDirection=UICollectionViewScrollDirectionVertical;
    cly.sectionInset=UIEdgeInsetsMake(0, 10, 5, 10);


    UICollectionView *collview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:cly];
    collview.delegate=self;
    collview.dataSource=self;
    UIImageView *image=[[UIImageView alloc]initWithFrame:collview.bounds];
    image.userInteractionEnabled=YES;
    image.image=[UIImage imageNamed:@"bg1.jpg"];
    collview.backgroundView=image;
    [self.view addSubview:collview];
    [collview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return arr.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //cell.backgroundColor=[UIColor whiteColor];

    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [btn setTitle:arr[indexPath.item] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imagearr[indexPath.item]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cellcolick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=1000+indexPath.item;
    [cell.contentView addSubview:btn];
    return cell;

}
-(void)cellcolick:(UIButton *)btn{
    switch (btn.tag) {
    
            case 1000:
            {
                SaveViewController *save=[[SaveViewController alloc]init];
                [self.navigationController pushViewController:save animated:YES];
            }
                break;
            case 1001:
            {
                hundredfoldVC *huvc=[[hundredfoldVC alloc]init];
                [self.navigationController pushViewController:huvc animated:YES];
            }
                break;
    
            case 1002:
            {
                [self creteAlearview];
            }
                break;
    
            case 1003:
            {
                peripheralViewController *perph=[[peripheralViewController alloc]init];
                [self.navigationController pushViewController:perph animated:YES];

            }
                break;
    
            case 1004:
            {
                [self.navigationController pushViewController:[UMFeedback feedbackViewController]            animated:YES];
            }
                break;
    
            case 1005:
            {
                view=[[UIView alloc]initWithFrame:self.view.bounds];
                view.backgroundColor=[UIColor clearColor];
                UIView *view2=[[UIView alloc]initWithFrame:view.bounds];
                view2.backgroundColor=[UIColor blackColor];
                view2.alpha=0.5;
                [view addSubview:view2];
                UILabel *label=[[UILabel alloc]initWithFrame:view2.bounds];
                label.text=@"应用开发中，更多功能敬请期待";
                label.textColor=[UIColor whiteColor];
                label.font=[UIFont boldSystemFontOfSize:35];
                label.numberOfLines=0;
                label.textAlignment=NSTextAlignmentCenter;
                [view addSubview:label];
                label.userInteractionEnabled=YES;
                [self.view addSubview:view];
                UITapGestureRecognizer *gs=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(heiden:)];
                [view addGestureRecognizer:gs];
            }
                break;
            default:
                break;
        }
}

-(void)heiden:(UITapGestureRecognizer*)tap{

    [view removeFromSuperview];
}

-(void)myClearCacheAction{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];

                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachePath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
}


-(void)clearCacheSuccess
{
    UIAlertView *allt=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"清理成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [self.view addSubview:allt];
    [allt show];
}
-(void)creteAlearview{
     NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
CGFloat fileSize = [self folderSizeAtPath:cachePath];
dispatch_async(dispatch_get_main_queue(), ^{
    NSString*title = [NSString stringWithFormat:@"%.2fMB",fileSize];
    NSString *str=[NSString stringWithFormat:@"删除缓存%@",title];

    UIAlertView *allt=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    allt.delegate=self;
    [self.view addSubview:allt];
    [allt show];
});


}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [self myClearCacheAction];
    }
}

- (CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }

    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];

    NSString *fileName = nil;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;

}

-(void)click:(UIButton*)btn{
    seachViewController *sch=[[seachViewController alloc]init];
    [self.navigationController pushViewController:sch animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
